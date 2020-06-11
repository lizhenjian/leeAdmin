<?php
// 应用公共文件
/**
 * 返回json数据，用于接口
 * @param int $code
 * @param string $msg
 * @param array $data
 * @param string $url
 * @param int $httpCode
 * @param array $header
 * @param array $options
 */
function json_result($code=200, $msg="OK", $data=[], $url='', $httpCode=200, $header = [], $options = []){
    $res=['code'=>$code];
    $res['msg']=$msg;
    $res['url']=$url;
    if(is_object($data)){
        $data=$data->toArray();
    }
    $res['data']=$data;
    $response = \think\Response::create($res, "json",$httpCode, $header, $options);
    throw new \think\exception\HttpResponseException($response);
}

/**
 * 附件地址
 * @param string $filepath
 * @return string
 */
function filepath($filepath = '')
{
    return config('app.tencent_cloud.domain') . $filepath;
}

function setFilepath($filepath)
{
    return str_replace(config('app.tencent_cloud.domain'), '', $filepath);
}
function order_no()
{
    return date('Ymd') . str_pad(mt_rand(1, 99999), 5, '0', STR_PAD_LEFT);
}
