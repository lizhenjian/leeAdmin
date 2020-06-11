<?php
declare (strict_types = 1);

namespace app\admin\controller\system;
use app\admin\BaseController;
use think\facade\Db;
use think\facade\View;

class Slide extends BaseController
{
    public function index()
    {
        if($this->request->isAjax())
        {
            $param = $this->param;

            $list = Db::name('slide_group')
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
                'name'      => 'require|unique:slide_group',
                'key'       => 'require|unique:slide_group',
            ]);

            if(false == Db::name('slide_group')->strict(false)->field(true)->insert($param)) {
                return json_result(202,'创建失败，请稍后再试');
            }
            return json_result(200,'创建成功');
        }
        else
        {
            return View::fetch();
        }

    }

    public function editGroup()
    {
        if($this->request->isPost())
        {
            $param = $this->param;

            $this->validate($param,[
                'id'        => 'require',
                'name'      => 'require|unique:slide_group',
                'key'       => 'require|unique:slide_group',
            ]);

            if(false == Db::name('slide_group')->strict(false)->field(true)->update($param)) {
                return json_result(202,'修改失败，请稍后再试');
            }

            return json_result(200,'修改成功');
        }
        else
        {
            $id = $this->param['id'];
            $data = Db::name('slide_group')->find($id);
            empty($data)?json_result(202,'查询的数据不存在'):View::assign('data',$data);
            return View::fetch();
        }
    }

    public function deleteGroup()
    {
        $id    = $this->param["id"];
        if(!$id) {
            return json_result(202,'缺少必要条件');
        }
        $count = Db::name('slide')->where(["slide_group_id" => $id])->count();
        if ($count > 0) {
            return json_result(202,"该分组下还存在轮播图，请先删除轮播图数据");
        }
        if (Db::name('slide_group')->delete($id) == false) {
            return json_result(202,"删除失败！");
        }
        return json_result(200,"删除成功！");
    }

    public function slideIndex()
    {
        $param = $this->param;

        if($this->request->isAjax())
        {
            if(empty($param['slide_group_id']))
            {
                return json_result(202,'非法请求');
            }

            $list = (new \app\common\model\Slide())
                    ->where('slide_group_id',$param['slide_group_id'])
                    ->order('sort desc')
                    ->paginate([
                        'list_rows' => isset($param['limit']) ? $param['limit'] : 20,
                        'page'      => isset($param['page']) ? $param['page'] : 1,
                        'query'     => $param
                    ]);
            return table_port(0,'',$list);
        }
        else
        {
            View::assign('slide_group_id',$param['slide_group_id']);
            return View::fetch();
        }
    }

    public function addSlide()
    {
        $param = $this->param;

        if($this->request->isPost())
        {
            $this->validate($param,[
                'icon'           => 'require',
                'slide_group_id' => 'require',
            ]);

            if(false == (new \app\common\model\Slide())->save($param)) {
                return json_result(202,'创建失败，请稍后再试');
            }
            return json_result(200,'创建成功');
        }
        else
        {
            View::assign('slide_group_id',$param['slide_group_id']);
            return View::fetch();
        }

    }

    public function editSlide()
    {
        if($this->request->isPost())
        {
            $param = $this->param;

            $this->validate($param,[
                'id'           => 'require',
                'icon'         => 'require',
            ]);
            $slide = new \app\common\model\Slide();
            $slide = $slide->find($param['id']);
            if(false == $slide->save($param)) {
                return json_result(202,'修改失败，请稍后再试');
            }

            return json_result(200,'修改成功');
        }
        else
        {
            $param = $this->param;
            $slide = new \app\common\model\Slide();
            $data = $slide->find($param['id']);
            empty($data)?json_result(202,'查询的数据不存在'):View::assign('data',$data);
            return View::fetch();
        }
    }

    public function deleteSlide()
    {
        $id    = $this->param["id"];
        if(!$id) {
            return json_result(202,'缺少必要条件');
        }
        if (Db::name('slide')->delete($id) == false) {
            return json_result(202,"删除失败！");
        }
        return json_result(200,"删除成功！");
    }
}
