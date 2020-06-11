<?php

namespace app\admin\middleware;

use app\common\model\AdminUserAction;
use think\facade\Session;
use think\facade\Request;
class AdminLog {

    public function handle($request, \Closure $next) {
        $response = $next($request);
        if(Session::get('adminToken')['id']){
            AdminUserAction::create([
                'uid'         => Session::get('adminToken')['id'],
                'nickname'    => Session::get('adminToken')['nickname'],
                'add_time'    => time(),
                'url'         => Request::controller().'/'.Request::action(true),
                'data'        => json_encode($request->param())
            ]);
        }
        return $response;
    }
}
