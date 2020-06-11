<?php

namespace app\api\controller\main;

use app\api\controller\Base;
use app\common\model\User;
use app\util\JsonWebToken;
use app\util\ReturnCode;
use EasyWeChat\Factory;
use think\Config;

class WechatUser extends Base
{
    /**
     * @var \EasyWeChat\OfficialAccount\Application
     */
    private $wechatApp;

    public function __construct()
    {
        parent::__construct();
        $this->wechatApp = Factory::officialAccount(config('wechat'));
    }
    /**
     * @api {get} api/main.WechatUser/login 微信公众号登录
     * @apiDescription 微信公众号登录
     * @apiName jssdk
     * @apiGroup main-TcUser
     * @apiParam {string} code
     * @apiSuccess  code 返回 1
     * @apiSampleRequest /api/main.WechatUser/login
     * @apiVersion 1.0.0
     */
    public function login()
    {
        $wechatUser = $this->wechatApp->oauth->user();
        if (!empty(($wechatUser['errcode']))) {
            return $this->buildFailed(ReturnCode::INVALID, '失败', $wechatUser['errmsg']);
        }
        $res = $wechatUser->getOriginal();
        $user = new User;
        $unionid = isset($res['unionid']) ? $res['unionid'] : '';
        $userId = $user->login([
            'openid' => $res['openid'],
            'nickname' => $res['nickname'],
            'avatar' => $res['headimgurl'],
            'unionid' => $unionid,
        ]);
        $jwt = new JsonWebToken();
        $jwtConfig = config('jwt');
        $expire = time() + $jwtConfig['exp'];
        $expire_refresh = time() + $jwtConfig['exp_refresh'];
        $token['user_id'] = $userId;
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


    /**
     * @api {get} api/main.WechatUser/loginTest 测试登录
     * @apiDescription 测试登录
     * @apiName loginTest
     * @apiGroup main-TcUser
     * @apiParam {string} uid
     * @apiParam {string} sign
     * @apiSuccess  code 返回1
     * @apiSampleRequest /api/main.WechatUser/loginTest
     * @apiVersion 1.0.0
     */
    public function loginTest()
    {
        if(input('sign')!= 'leeadmin') return $this->buildFailed(ReturnCode::LOGIN_ERROR,'非法请求');
        $jwt = new JsonWebToken();
        $jwtConfig = config('app.jwt');
        $expire = time() + $jwtConfig['exp'];
        $expire_refresh = time() + $jwtConfig['exp_refresh'];
        $token['user_id'] = input('uid',1);
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
