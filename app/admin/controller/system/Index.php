<?php
namespace app\admin\controller\system;
use app\admin\BaseController;
use app\util\ReturnCode;
use Qcloud\Cos\Client as CosClient;
use think\facade\Db;
use think\facade\Cache;
use think\facade\Env;
use think\facade\View;
use think\facade\Session;
use think\facade\Config;

class Index extends BaseController
{

    public function index()
    {
        View::assign('uInfo',Session::get('adminToken'));
        return View::fetch();
    }

    public function console()
    {
        return View::fetch();
    }

    public function getAdminMenuList()
    {
        if(!Cache::get('uRulesMenu'.$this->user['id']))
        {
            //用户所在权限组及所拥有的权限
            if($this->user['id'] == 1)
            {
                //id=1的管理员默认拥有所有权限
                $uRulesMenu = Db::name('admin_rule')->where('is_menu',1)->order('sort desc')->field('id,pid,title,src as href,font_family as fontFamily,icon')->select()->toArray();
            }
            else
            {
                $uGroupIds = explode(',',Db::name('admin')->where('id',$this->user['id'])->value('groups'));
                $uRuleIds  = Db::name('admin_group')->where('id','IN',$uGroupIds)->where('status',1)->column('rules','id');

                $uRules    = [];
                foreach ($uRuleIds as $k => $v) {
                  $uRules = array_keys(array_flip($uRules)+array_flip(explode(',',$v)));
                }

                //用户所拥有的所有菜单
                $uRulesMenu = Db::name('admin_rule')->where('id','in',$uRules)->where('is_menu',1)->order('sort desc')->field('id,pid,title,src as href,font_family as fontFamily,icon')->select()->toArray();
            }

            foreach ($uRulesMenu as $k => $v) {
                if(!empty($v['href'])) {
                    $uRulesMenu[$k]['href'] = (string)url($v['href']);
                }
            }

            $uRulesMenu = list_to_tree($uRulesMenu);

            Cache::tag('adminRulesSrc')->set('uRulesMenu'.$this->user['id'],$uRulesMenu,36000);
        }
        $indexUrl = (string)url(('admin/system.index/console'));
        $uRulesMenu     = Cache::get('uRulesMenu'.$this->user['id']);
        $result_menu['homeInfo'] = ['title'=>'首页','href'=>$indexUrl];
        $result_menu['logoInfo'] = ['title'=>'LeeAdmin','image'=>'/static/admin_static/images/logo.png','href'=>(string)url(('admin/system.index/editAdminInfo'))];
        $result_menu['menuInfo'] = $uRulesMenu;
        return json($result_menu);
    }

    public function cacheClear()
    {
        try {
            Cache::clear();
        } catch (\Exception $e) {
            return json_result(202,$e->getMessage());
        }
        return json_result(200,'清除成功');
    }

    public function adminLogout()
    {
        try {
            Session::delete('adminToken');
        } catch (\Exception $e) {
            return json_result(202,$e->getMessage());
        }
        return json_result(200,'已为您注销登录,再会！',(string)url('admin/publicer/adminLogin'));
    }


    public function getRuleList()
    {
        if($this->request->isAjax())
        {
            $list = Db::name('admin_rule')
                    ->field('id,pid,title,is_menu')
                    ->select()
                    ->toArray();
            foreach ($list as $k => $v) {
                $v['is_menu'] == 1?$list[$k]['title'] = '<span class="layui-badge">权限</span> <span class="layui-badge layui-bg-blue">菜单</span> ' . $v['title']:$list[$k]['title'] = '<span class="layui-badge">权限</span> ' . $v['title'];
            }
            return json_result(200,'',list_to_tree($list, $pk = 'id', $pid = 'pid', $child = 'children', $root = 0));
        }
        else
        {
            return json_result(202,'非法请求');
        }
    }

    public function upload(){
        // 获取表单上传文件 例如上传了001.jpg
        $param['image'] = request()->file('file');

        // dump($param['image']);die;

        $validate = \think\facade\Validate::rule([
            'image'  => 'require|fileSize:102400|fileExt:jpg,png,jpeg,gif',
        ]);

        if (!$validate->check($param)) {
            return json_result(202,$validate->getError());
        }
        //

        $file = $param['image'];
        $savename = \think\facade\Filesystem::disk('public')->putFile( 'topic', $file);

        if($savename) {
            $path = Config::get('filesystem.disks.public.url');
            $data   = $path.'/'.$savename;
            return json_result(200,'上传成功',$data);
        }
        else
        {
            return json_result(202,'上传失败，请稍后再试');
        }
    }
/*
    public function upload()
    {
        $file = request()->file('file');

        if (!$file) {
            return json_result(202, '文件不存在');
        }
        $temp = explode(".",$_FILES['file']['name']);
        $fileType = end($temp);
        $config = config('app.tencent_cloud');
        $cosClient = new CosClient([
            'region' => $config['region'],
            'credentials' => [
                'secretId' => $config['secret_id'],
                'secretKey' => $config['secret_key'],
            ],
        ]);
        $key = '/storage/' . date('Ymd') . '/' . md5(microtime(true)) . '.' . $fileType;
        try {
            $result = $cosClient->putObject([
                'Bucket' => $config['bucket'],
                'Key' => $key,
                'Body' => fopen($_FILES['file']['tmp_name'], 'rb'),
            ]);
        } catch (\Exception $e) {
            return json_result(202,$e->getMessage());
        }
        return json_result(200,'上传成功',filepath($key));
    }
*/

    public function errorShow($msg = '你没有这个操作的权限呀~')
    {
        View::assign('msg',$msg);
        return View::fetch();
    }

    public function editAdminInfo()
    {
        if($this->request->isPost())
        {
            $param = $this->param;

            $this->validate($param,[
                'nickname'       => 'require',
                'thumb'          => 'require',
            ]);

            if(!empty($param['password']))
            {
                //重置密码
                if(empty($param['password_confirm']) or $param['password_confirm'] !== $param['password']) {
                    return json_result(202,'两次密码不一致');
                }
                $param['salt'] = set_salt(20);
                $param['pwd']  = generate_pwd($param['password'],$param['salt']);
            }
            else
            {
                unset($param['pwd']);
                unset($param['salt']);
            }

            $param['update_time'] = time();
            $param['id']          = Session::get('adminToken')['id'];

            unset($param['groups']);

            if(false == Db::name('admin')->strict(false)->field(true)->update($param))
            {
                return json_result(202,'修改失败，请稍后再试');
            }

            return json_result(200,'修改成功,重新登录后生效');
        }
        else
        {
            View::assign('admin',Session::get('adminToken'));
            return View::fetch('admin@system/admin/edit_admin_info');
        }
    }
}
