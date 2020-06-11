<?php
declare (strict_types = 1);

namespace app\admin\controller\system;
use app\admin\BaseController;
use think\facade\Db;
use think\facade\Session;
use think\facade\View;

class Publicer extends BaseController
{

    public function adminLogin()
    {
        if(Session::has('adminToken')){
            return redirect((string)url('/admin/system.index/index'));
        }
        return View::fetch();
    }

    public function adminLoginSubmit()
    {
        $param = $this->param;
        $this->validate($param,[
            // 'captcha|验证码'=>'require|captcha',
            'username|用户名'  => 'require',
            'password|密码'    => 'require'
        ]);

		$admin = Db::name('admin')->where(['username'=>$param['username']])->find();
        if(empty($admin)) {
            return json_result(202,'用户名或密码错误');
        }
        $param['pwd'] = generate_pwd($param['password'],$admin['salt']);
        if($admin['pwd'] !== $param['pwd']) {
            return json_result(202,'用户名或密码错误');
        }
        if($admin['status'] == 0){
            return json_result(202,'该用户禁止登陆,请于系统所有者联系');
        }

        Session::set('adminToken', [
                                        'id'             => $admin['id'],
                                        'thumb'          => $admin['thumb'],
                                        'nickname'       => $admin['nickname']
                                    ]);

        $data = [
            'last_login_time' => time(),
            'last_login_ip'   => $this->request->ip(),
        ];
        Db::name('admin')->where(['id'=>$admin['id']])->update($data);
        return json_result(200,'登入成功');
    }
}
