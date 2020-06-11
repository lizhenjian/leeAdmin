<?php

namespace app\api\controller\main;

use app\api\controller\Base;
use app\util\JsonWebToken;
use app\util\ReturnCode;
use think\facade\App;

class Jwt extends Base {

    /**
     * @api {get} api/main.TcUser/refreshJwt 刷新refresh_token
     * @apiDescription  刷新refresh_token
     * @apiName refreshJwt
     * @apiGroup main-TcUser
     * @apiParam {string} refresh_token
     * @apiSuccess  code 返回1
     * @apiSampleRequest /api/main.TcUser/refreshJwt
     * @apiVersion 1.0.0
     */
    public function refreshJwt()
    {
        $jwt = new JsonWebToken();
        $jwtConfig = config('app.jwt');
        $expire = time() + $jwtConfig['exp'];
        $expire_refresh = time() + $jwtConfig['exp_refresh'];
        try {
            $data = $jwt->setKey($jwtConfig['key'])->checkToken(input('refresh_token'));
        } catch (\Exception $e) {
            return $this->buildFailed(ReturnCode::LOGIN_ERROR, $e->getMessage());
        }
        $token = [
            'user_id' => $data['user_id'],
        ];
        $access_token = $token;
        $access_token['scopes'] = 'role_access'; //token标识，请求接口的token
        $access_token['exp'] = $expire; //access_token过期时间,这里设置2个小时
        $refresh_token = $token;
        $refresh_token['scopes'] = 'role_refresh'; //token标识，刷新access_token
        $refresh_token['exp'] = $expire_refresh; //access_token过期时间,这里设置30天
        $jsonList = [
            'access_token'=>$jwt->setKey($jwtConfig['key'])->createToken($access_token),
            'refresh_token'=>$jwt->setKey($jwtConfig['key'])->createToken($refresh_token),
            'token_type'=>'bearer' //token_type：表示令牌类型，该值大小写不敏感，这里用bearer
        ];
        return $this->buildSuccess($jsonList, 'ok');
    }
}
