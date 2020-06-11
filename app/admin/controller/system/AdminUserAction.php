<?php
declare (strict_types = 1);

namespace app\admin\controller\system;
use app\admin\BaseController;
use think\facade\Db;
use think\facade\Cache;
use think\facade\View;
use app\common\model\AdminUserAction as AdminUserActionmodel;

class AdminUserAction extends BaseController
{
    public function initialize()
    {
        parent::initialize();
        $this->adminModel     = new AdminUserActionmodel();
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
}
