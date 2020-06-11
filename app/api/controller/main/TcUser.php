<?php

namespace app\api\controller\main;
use app\api\controller\BaseAuth;
use app\common\model\User;
use app\util\JsonWebToken;
use app\util\ReturnCode;
use EasyWeChat\Factory;
use think\facade\Config;

class TcUser extends BaseAuth
{
    public function profile()
    {
        $user = new User;
        $userInfo = $user->getUserInfo($this->getUserId());
        return $this->buildSuccess($userInfo, 'ok');
    }

    /**
     * @api {post} api/main.TcUser/update 用户信息更新
     * @apiDescription  用户信息更新
     * @apiName update
     * @apiGroup main-TcUser
     * @apiParam {string} code
     * @apiParam {string} nickName 姓名
     * @apiParam {int} gender 性别
     * @apiParam {string} avatarUrl 头像
     * @apiSuccess  code 返回1
     * @apiSampleRequest /api/main.TcUser/update
     * @apiVersion 1.0.0
     */
    public function update()
    {
        $param = input();
        $user = new User;
        $data['id'] = $this->getUserId();
        if ($param['nickName']) {
            $data['nickname'] = $param['nickName'];
        }
        if ($param['gender']) {
            $data['sex'] = $param['gender'];
        }
        if ($param['avatarUrl']) {
            $data['avatar'] = $param['avatarUrl'];
        }
        $result = $user->updateUser($data);
        if ($result === false) {
            return $this->buildFailed(ReturnCode::INVALID, '修改失败');
        }
        return $this->buildSuccess('', 'ok');
    }
}
