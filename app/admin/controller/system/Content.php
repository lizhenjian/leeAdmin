<?php
declare (strict_types = 1);

namespace app\admin\controller\system;
use app\admin\BaseController;
use think\facade\Db;
use think\facade\View;

class Content extends BaseController
{
    public function index()
    {
        if($this->request->isAjax())
        {
            $param = $this->param;

            $list = Db::name('content_group')
                    ->alias('a')
                    ->field('a.*,b.name as cate_name')
                    ->join('cate_group b','b.id = a.cate_group_id')
                    ->paginate([
                        'list_rows' => isset($param['limit']) ? $param['limit'] : 20,
                        'page'      => isset($param['page']) ? $param['page'] : 1,
                        'query'     => $param
                    ]);
            return table_port(0,'',$list);
        }
        else
        {
            return View::fetch();
        }
    }
    public function addGroup()
    {
        if($this->request->isPost())
        {
            $param = $this->param;

            $this->validate($param,[
                'name'          => 'require|unique:content_group',
                'key'           => 'require|unique:content_group',
                'cate_group_id' => 'require',
            ]);

            if(false == Db::name('content_group')->strict(false)->field(true)->insert($param)) {
                return json_result(202,'创建失败，请稍后再试');
            }
            return json_result(200,'创建成功');
        }
        else
        {
            View::assign('cate_group',Db::name('cate_group')->select()->toArray());
            return View::fetch();
        }

    }

    public function editGroup()
    {
        if($this->request->isPost())
        {
            $param = $this->param;

            $this->validate($param,[
                'id'            => 'require',
                'name'          => 'require|unique:content_group',
                'key'           => 'require|unique:content_group',
                'cate_group_id' => 'require',
            ]);

            if(false == Db::name('content_group')->strict(false)->field(true)->update($param)) {
                return json_result(202,'修改失败，请稍后再试');
            }

            return json_result(200,'修改成功');
        }
        else
        {
            $id = $this->param['id'];
            $data = Db::name('content_group')->find($id);
            empty($data)?json_result(202,'查询的数据不存在'):View::assign('data',$data);
            View::assign('cate_group',Db::name('cate_group')->select()->toArray());
            return View::fetch();
        }
    }

    public function deleteGroup()
    {
        $id    = $this->param["id"];
        if(!$id) {
            return json_result(202,'缺少必要条件');
        }
        $count = Db::name('content')->where(["content_group_id" => $id])->count();
        if ($count > 0) {
            return json_result(202,"该分组下还存在内容，请先删除内容数据");
        }
        if (Db::name('content_group')->delete($id) == false) {
            return json_result(202,"删除失败！");
        }
        return json_result(200,"删除成功！");
    }

    public function contentIndex()
    {
        $param = $this->param;

        if($this->request->isAjax())
        {
            if(empty($param['content_group_id']))
            {
                return json_result(202,'非法请求');
            }
            $content = new \app\common\model\Content();
            $list = $content
                    ->where('content_group_id',$param['content_group_id'])
                    ->order('sort create_time desc')
                    ->paginate([
                        'list_rows' => isset($param['limit']) ? $param['limit'] : 20,
                        'page'      => isset($param['page']) ? $param['page'] : 1,
                        'query'     => $param
                    ])
                    ->each(function($item, $key){
                        // $item['img']         = explode(',',$item['img']);
//                        $item['create_time'] = date('Y-m-d',$item['create_time']);
                        $item['cate_name']   = Db::name('cate')->where('id',$item['cate_id'])->value('title');
                        return $item;
                    });
            return table_port(0,'',$list);
        }
        else
        {
            View::assign('content_group_id',$param['content_group_id']);
            return View::fetch();
        }
    }

    public function addContent()
    {
        $param = $this->param;

        if($this->request->isPost())
        {
            $this->validate($param,[
                'title'            => 'require',
                'img'              => 'require',
                'content_group_id' => 'require',
            ]);

            // $param['img'] = implode(',', $param['img']);
            $content = new \app\common\model\Content();
            if(false == $content->save($param)) {
                return json_result(202,'创建失败，请稍后再试');
            }
            return json_result(200,'创建成功');
        }
        else
        {
            View::assign('content_group_id',$param['content_group_id']);
            View::assign('cate',Db::name('cate')->where('cate_group_id',Db::name('content_group')->where('id',$param['content_group_id'])->value('cate_group_id'))->select()->toArray());
            return View::fetch();
        }

    }

    public function editContent()
    {
        if($this->request->isPost())
        {
            $param = $this->param;

            $this->validate($param,[
                'id'               => 'require',
                'title'            => 'require',
                'img'              => 'require',
            ]);
            $content = new \app\common\model\Content();
            $content = $content->find($param['id']);
            if(false == $content->save($param)) {
                return json_result(202,'修改失败，请稍后再试');
            }

            return json_result(200,'修改成功');
        }
        else
        {
            $id = $this->param['id'];
            $data = (new \app\common\model\Content())->find($id);
            empty($data)?json_result(202,'查询的数据不存在'):View::assign('data',$data);
            View::assign('cate',Db::name('cate')->where('cate_group_id',Db::name('content_group')->where('id',$data['content_group_id'])->value('cate_group_id'))->select()->toArray());
            return View::fetch();
        }
    }

    public function deleteContent()
    {
        $id    = $this->param["id"];
        if(!$id) {
            return json_result(202,'缺少必要条件');
        }
        if (Db::name('content')->delete($id) == false) {
            return json_result(202,"删除失败！");
        }
        return json_result(200,"删除成功！");
    }
}
