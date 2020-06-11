<?php
namespace app\api\controller;

use app\util\ReturnCode;
use think\exception\HttpResponseException;

class Base extends BaseController {

    private $debug = [];
    protected $userInfo = [];

    public function buildSuccess($data = [], $msg = '操作成功', $code = ReturnCode::SUCCESS) {
        $return = [
            'code' => $code,
            'msg'  => $msg,
            'data' => !empty($data) ? $data : (object)[]
        ];
        if (config('app.app_debug') && $this->debug) {
            $return['debug'] = $this->debug;
        }

        throw new HttpResponseException(json($return));
    }

    public function buildFailed($code, $msg = '操作失败', $data = []) {
        $return = [
            'code' => $code,
            'msg'  => $msg,
            'data' => $data
        ];
        if (config('app.app_debug') && $this->debug) {
            $return['debug'] = $this->debug;
        }

        throw new HttpResponseException(json($return));
    }

    protected function debug($data) {
        if ($data) {
            $this->debug[] = $data;
        }
    }
}
