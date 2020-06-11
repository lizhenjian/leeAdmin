<?php
declare (strict_types=1);

namespace app\admin\controller\system;

use app\admin\BaseController;
use think\facade\Db;
use think\facade\Cache;
use think\facade\View;

class Menu extends BaseController
{
    public function index()
    {
        if ($this->request->isAjax()) {
            $where = [];
            if (!empty($param['keywords'])) {
                $where[] = ['title', 'like', $this->param['keywords'] . '%'];
            }
            $list = Db::name('admin_rule')
                ->where($where)
                ->select()
                ->toArray();
            return json_result(200, '', $list);
        } else {
            return View::fetch();
        }
    }

    public function add()
    {
        if ($this->request->isAjax()) {
            $param = $this->param;

            $this->validate($param, [
                'pid' => 'require',
                'title' => 'require',
            ]);

            $param['is_menu'] = empty($param['is_menu']) ? 0 : $param['is_menu'];

            if (false == Db::name('admin_rule')->strict(false)->field(true)->insert($param)) {
                return json_result(202, '修改失败，请稍后再试');
            }
            //清除所有菜单缓存
            Cache::tag('adminRulesSrc')->clear();
            return json_result(200, '添加成功');
        } else {
            View::assign('menu', Db::name('admin_rule')->select()->toArray());
            return View::fetch();
        }
    }

    public function edit()
    {
        if ($this->request->isPost()) {
            $param = $this->param;

            $this->validate($param, [
                'id' => 'require',
                'pid' => 'require',
                'title' => 'require',
            ]);

            $param['is_menu'] = empty($param['is_menu']) ? 0 : $param['is_menu'];

            if (false == Db::name('admin_rule')->strict(false)->field(true)->update($param)) {
                return json_result(202, '修改失败，请稍后再试');
            }
            //清除所有菜单缓存
            Cache::tag('adminRulesSrc')->clear();
            return json_result(200, '修改成功');
        } else {
            $id = $this->param['id'];

            if (!$id) {
                return json_result(202, '缺少必要条件');
            }

            $data = Db::name('admin_rule')->field('id,pid,title,src,is_menu,font_family,icon,sort')->find($id);

            if (empty($data)) {
                return json_result(202, '查询的数据不存在');
            }
            View::assign('data', $data);
            View::assign('menu', Db::name('admin_rule')->select()->toArray());
            return View::fetch();
        }

    }

    public function delete()
    {
        $id = $this->param['id'];
        if (!$id) {
            return json_result(202, '缺少必要条件');
        }
        $count = Db::name('admin_rule')->where(["pid" => $id])->count();
        if ($count > 0) {
            return json_result(202, "该菜单下还存在子菜单，请先删除子菜单！");
        }
        if (Db::name('admin_rule')->delete($id) == false) {
            return json_result(202, "删除失败！");
        }
        return json_result(200, "删除成功！");
    }
}
