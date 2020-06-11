<?php
namespace app\api\controller;

use app\common\model\User;
use app\util\JsonWebToken;
use app\util\ReturnCode;
use think\App;
use think\facade\Request as FRequest;

class BaseAuth extends Base
{
    private $user_id;

    public function __construct()
    {
        parent::__construct();
        $token = isset(FRequest::header()['access-token']) ? FRequest::header()['access-token'] : '';
        $jwt = new JsonWebToken();
        $jwtConfig = config('app.jwt');
        try {
            $data = $jwt->setKey($jwtConfig['key'])->checkToken($token);

            $this->user_id = $data['user_id'];
        } catch (\Exception $e) {
            return $this->buildFailed(ReturnCode::LOGIN_ERROR, $e->getMessage());
        }
    }

    protected function getUserId()
    {
        return $this->user_id;
    }

    protected function getUserInfo()
    {
        $user = new User();
        return $user->getUserInfo($this->getUserId());
    }
}
