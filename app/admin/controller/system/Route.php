<?php
namespace app\admin\controller\system;
use app\admin\BaseController;
use think\facade\Db;
use think\facade\View;
use think\facade\Cache;

class Route extends BaseController
{
    public function index()
    {
        if($this->request->isAjax())
        {
            $param = $this->param;
            $where = array();
            if(!empty($param['keywords'])) {
                $where[] = ['id|full_url|url','like',$param['keywords'].'%'];
            }
            $route = Db::name('route')
                    ->order('create_time asc')
                    ->paginate([
                        'list_rows' => isset($param['limit']) ? $param['limit'] : 20,
                        'page'      => isset($param['page']) ? $param['page'] : 1,
                        'query'     => $param
                    ]);
            return table_port(0,'',$route);
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
                'module'         => 'require',
                'full_url'       => 'require|unique:route',
                'url'            => 'require|unique:route',
            ]);
            $param['create_time'] = time();

            if(false == Db::name('route')->strict(false)->field(true)->insert($param))
            {
                return json_result(202,'创建失败，请稍后再试');
            }
            Cache::delete('route_'.$param['module']);
            return json_result(200,'创建成功');
        }
        else
        {
            return View::fetch();
        }
    }

    public function edit()
    {
        $param = $this->param;

        if($this->request->isPost())
        {
            $this->validate($param,[
                'module'         => 'require',
                'full_url'       => 'require|unique:route',
                'url'            => 'require|unique:route',
                'status'         => 'require',
                'id'             => 'require',
            ]);

            $param['update_time'] = time();

            if(false == Db::name('route')->strict(false)->field(true)->update($param))
            {
                return json_result(202,'修改失败，请稍后再试');
            }
            Cache::delete('route_'.$param['module']);
            return json_result(200,'修改成功');
        }
        else
        {
            $data = Db::name('route')->find($param['id']);
            empty($data)?json_result('202','查询的数据不存在'):View::assign('data',$data);
            return View::fetch();
        }
    }

    public function delete()
    {
        $param    = $this->param;
        if (Db::name('Route')->delete($param['id']) !== false) {
            Cache::delete('route_'.$param['module']);
            return json_result(200,"删除成功！");
        } else {
            return json_result(202,"删除失败！");
        }
    }
}
