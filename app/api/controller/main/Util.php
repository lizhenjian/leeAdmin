<?php

namespace app\api\controller\main;

use AlibabaCloud\Client\AlibabaCloud;
use AlibabaCloud\Client\Exception\ClientException;
use AlibabaCloud\Client\Exception\ServerException;
use Qcloud\Sms\SmsSingleSender;
use Qcloud\Cos\Client as CosClient;
use app\api\controller\BaseAuth;
use app\common\model\User;
use app\util\ReturnCode;
use GuzzleHttp\Client;
use think\Cache;
use think\facade\Env;

class Util extends BaseAuth
{
    /**
     * @api {post} api/main.util/upload 上传文件
     * @apiDescription 上传文件(本地存储)
     * @apiName upload
     * @apiGroup main-util
     * @apiParam {file} file 文件
     * @apiSuccess  code 返回 1
     * @apiSampleRequest /api/main.util/upload
     * @apiVersion 1.0.0
     */
    public function upload()
    {
        // 手机上传文件没有后缀时自动添加
        if (isset($_FILES['file'])) {
            $file = $_FILES['file'];
            if (!strpos($file['name'], '.')) {
                $typeData = explode('/', $file['type']);
                $file['name'] .= '.' . $typeData[1];
            }
            $_FILES['file'] = $file;
        }

        $file = request()->file('file');
        if (!$file) {
            return $this->buildFailed(ReturnCode::INVALID, '文件不存在');
        }
        $info = $file->move(Env::get('root_path') . 'public' . DIRECTORY_SEPARATOR . 'uploads');
        if (!$info) {
            return $this->buildFailed(ReturnCode::INVALID, '上传失败');
        }
        $image = '/uploads/' . $info->getSaveName();
        $path = Env::get('root_path') . 'public' . $image;
        if (getimagesize($path)[0] > 1200) {
            // resize($path, 1200, null);
        }
        return $this->buildSuccess([
            'file' => request()->domain() . $image,
        ], 'ok');
    }
    /**
     * @api {post} api/main.util/uploadCloud 上传文件
     * @apiDescription 上传文件(腾讯云对象存储)
     * @apiName uploadCloud
     * @apiGroup main-util
     * @apiParam {file} file 文件
     * @apiSuccess  code 返回 1
     * @apiSampleRequest /api/main.util/uploadCloud
     * @apiVersion 1.0.0
     */
    public function uploadCloud()
    {
        $file = request()->file('file');

        if (!$file) {
            return $this->buildFailed(ReturnCode::INVALID, '文件不存在');
        }
        $temp = explode(".",$_FILES['file']['name']);
        $fileType = end($temp);
        $config = config('app.tencent_cloud');
        $cosClient = new CosClient([
            'region' => $config['region'],
            'credentials' => [
                'secretId' => $config['secret_id'],
                'secretKey' => $config['secret_key'],
            ],
        ]);
        $key = '/uploads/' . date('Ymd') . '/' . md5(microtime(true)) . '.' . $fileType;
        try {
            $result = $cosClient->putObject([
                'Bucket' => $config['bucket'],
                'Key' => $key,
                'Body' => fopen($_FILES['file']['tmp_name'], 'rb'),
            ]);
        } catch (\Exception $e) {
            return $this->buildFailed(ReturnCode::INVALID,$e->getMessage());
        }
        return $this->buildSuccess([
            'file' => filepath($key),
        ]);
    }

    /**
     * @api {get} api/main.util/jssdk 获取微信JSSDK
     * @apiDescription 获取微信JSSDK
     * @apiName jssdk
     * @apiGroup main-util
     * @apiParam {array} js_api_list 接口API列表
     * @apiParam {string} url 链接
     * @apiSuccess  code 返回 1
     * @apiSampleRequest /api/main.util/jssdk
     * @apiVersion 1.0.0
     */
    public function jssdk()
    {
        $jsApiList = input('js_api_list') ? input('js_api_list') : [
            'updateAppMessageShareData',
            'updateTimelineShareData',
        ];
        $url = input('url');
        $config = config('wechat');
        $app = Factory::officialAccount($config);
        $jssdk = $app->jssdk->setUrl($url)->getConfigArray($jsApiList, config('app_debug'));
        return $this->buildSuccess($jssdk, 'ok', 0);
    }


}
