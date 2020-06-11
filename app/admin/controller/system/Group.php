<?php
declare (strict_types = 1);

namespace app\admin\controller\system;
use app\admin\BaseController;
use think\facade\Db;
use think\facade\Cache;
use think\facade\View;

class Group extends BaseController
{
    public function index()
    {
        if($this->request->isAjax())
        {
            $param = $this->param;
            $where = [];
            if(!empty($param['keywords'])) {
                $where[] = ['title|desc','like',$param['keywords'].'%'];
            }
            $list = Db::name('admin_group')
                    ->field('id,title,status,desc')
                    ->where($where)
                    ->paginate([
                        'list_rows' => isset($param['list_rows']) ? $param['list_rows'] : 20,
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

    public function add()
    {
        if($this->request->isAjax())
        {
            $param = $this->param;

            $this->validate($param,[
                'title'       => 'require|unique:admin_group',
            ]);

            $param['rules'] = empty($param['rules'])?'':implode(',',$param['rules']);
            $param['create_time'] = time();

            if(false == Db::name('admin_group')->strict(false)->field(true)->insert($param)) {
                return json_result(202,'创建失败，请稍后再试');
            }
            return json_result(200,'创建成功');
        }
        else
        {
            return View::fetch();
        }

    }
    public function edit()
    {
        if($this->request->isPost())
        {
            $param = $this->param;

            $this->validate($param,[
                'id'          => 'require',
                'title'       => 'require|unique:admin_group',
            ]);

            $param['rules'] = empty($param['rules'])?'':implode(',',$param['rules']);

            $param['update_time'] = time();

            if(false == Db::name('admin_group')->strict(false)->field(true)->update($param)) {
                return json_result(202,'修改失败，请稍后再试');
            }
            Cache::tag('adminRulesSrc')->clear();
            return json_result(200,'修改成功');
        }
        else
        {
            $id = $this->param['id'];

            if(!$id) {
                return json_result(202,'缺少必要条件');
            }

            $group = Db::name('admin_group')->find($id);
            if(empty($group)) {
                return json_result(202,'查询的数据不存在');
            }
            // 为了配合layui的tree组件存在的bug，这里将已勾选的id倒叙
            $group['rules'] = array_reverse(explode(',',$group['rules']));
            View::assign('group',$group);
            return View::fetch();
        }

    }

    public function delete()
    {
        $id    = $this->param["id"];
        if(!$id) {
            return json_result(202,'缺少必要条件');
        }
        if (Db::name('admin_group')->delete($id) == false) {
            return json_result(202,"删除失败！");
        }
        Cache::tag('adminRulesSrc')->clear();
        return json_result(200,"删除成功！");
    }
}
