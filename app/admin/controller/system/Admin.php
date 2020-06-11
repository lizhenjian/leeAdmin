<?php
declare (strict_types = 1);

namespace app\admin\controller\system;
use app\admin\BaseController;
use think\facade\Db;
use think\facade\Cache;
use think\facade\View;
use think\facade\Session;
use app\common\model\Admin as AdminModel;

class Admin extends BaseController
{
    /**
     * @var AdminModel
     */
    private $adminModel;

    public function initialize()
    {
        parent::initialize();
        $this->adminModel     = new AdminModel();
    }
    public function index()
    {
        if($this->request->isAjax())
        {
            $param = $this->param;
            $list = $this->adminModel->getList($param);
            return table_port(0,'',$list);
        }
        else
        {
            return View::fetch();
        }
    }

    public function add()
    {
        if($this->request->isPost())
        {
            $param = $this->param;

            $this->validate($param,[
                'username'       => 'require|unique:admin',
                'password'       => 'require|confirm',
                'nickname'       => 'require',
                'thumb'          => 'require',
                'group_id'       => 'require',
            ]);

            $param['salt']        = set_salt(20);
            $param['pwd']         = generate_pwd($param['password'],$param['salt']);
            $param['groups']      = implode(',',$param['group_id']);
            $param['create_time'] = time();

            if(false == Db::name('admin')->strict(false)->field(true)->insert($param)) {
                return json_result(202,'创建失败，请稍后再试');
            }
            return json_result(200,'创建成功');
        }
        else
        {
            View::assign('group',Db::name('admin_group')->where('status',1)->select()->toArray());
            return View::fetch();
        }

    }

    public function edit()
    {
        if($this->request->isPost())
        {
            $param = $this->param;

            $this->validate($param,[
                'id'             => 'require',
                'nickname'       => 'require',
                'thumb'          => 'require',
                'group_id'       => 'require',
            ]);

            // 不允许其他管理员修改id=1的管理员
            if($param['id'] == 1 and Session::get('admin_tiken')['id'] !== 1)
            {
                return json_result(202,'不允许其他人修改系统所有者');
            }

            unset($param['username']);
            if(!empty($param['password'])) {
                //重置密码
                if(empty($param['password_confirm']) or $param['password_confirm'] !== $param['password']) {
                    return json_result(202,'两次密码不一致');
                }
                $param['salt'] = set_salt(20);
                $param['pwd']  = generate_pwd($param['password'],$param['salt']);
            } else {
                unset($param['pwd']);
                unset($param['salt']);
            }
            $param['groups']      = implode(',',$param['group_id']);
            $param['update_time'] = time();

            if(false == Db::name('admin')->strict(false)->field(true)->update($param)) {
                return json_result(202,'修改失败，请稍后再试');
            }
            Cache::delete('uRulesSrc'.$param['id']);

            return json_result(200,'修改成功');
        }
        else
        {
            $id = $this->param['id'];
            $data = Db::name('admin')->find($id);
            empty($data)?json_result(202,'查询的数据不存在'):$data['groups']=explode(',', $data['groups']);
            View::assign('data',$data);
            View::assign('group',Db::name('admin_group')->where('status',1)->select()->toArray());
            return View::fetch();
        }
    }

    public function delete()
    {
        $id    = $this->param["id"];
        if(!$id) {
            return json_result(202,'缺少必要条件');
        }
        if ($id == 1) {
            return json_result(202,"系统拥有者，无法删除！");
        }
        if (Db::name('admin')->delete($id) == false) {
            return json_result(202,"删除失败！");
        }
        return json_result(200,"删除管理员成功！");
    }
}
