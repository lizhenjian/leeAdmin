<?php
// +----------------------------------------------------------------------
// | 应用设置
// +----------------------------------------------------------------------

return [
    // 应用地址
    'app_host'         => env('app.host', ''),
    // 应用的命名空间
    'app_namespace'    => '',
    // 是否启用路由
    'with_route'       => true,
    // 是否启用事件
    'with_event'       => true,
    // 默认应用
    'default_app'      => 'index',
    // 默认时区
    'default_timezone' => 'Asia/Shanghai',

    // 应用映射（自动多应用模式有效）
    'app_map'          => [],
    // 域名绑定（自动多应用模式有效）
    'domain_bind'      => [],
    // 禁止URL访问的应用列表（自动多应用模式有效）
    'deny_app_list'    => [],

    // 异常页面的模板文件
    'exception_tmpl'   => app()->getThinkPath() . 'tpl/think_exception.tpl',

    // 错误显示信息,非调试模式有效
    'error_message'    => '页面错误！请稍后再试～',
    // 显示错误信息
    'show_error_msg'   => false,
    //分页配置
    'paginate'   => [
        'type'      => 'bootstrap',
        'var_page'  => 'page',
        'list_rows' => 10,
    ],
//跨域配置
    'CROSS_DOMAIN'          => [
        'Access-Control-Allow-Origin'      => '*',
        'Access-Control-Allow-Methods'     => 'POST,PUT,GET,DELETE',
        'Access-Control-Allow-Headers'     => 'version, access-token, user-token, apiAuth, User-Agent, Keep-Alive, Origin, No-Cache, X-Requested-With, If-Modified-Since, Pragma, Last-Modified, Cache-Control, Expires, Content-Type, X-E4M-With',
        'Access-Control-Allow-Credentials' => 'true'
    ],

    'sms' => [
        'appid' => '',
        'appkey' => '',
    ],
    'mini_wechat' => [
        'app_id' => '',
        'secret' => '',
        'mch_id' => '',
        'key' => '',
        // 'notify_url' => '/port/order/notify',
        'log' => [
            'level'      => 'debug',
            'permission' => 0777,
            'file'       =>runtime_path().'/wechat/' . date('Y-m') . '/' . date('d') . '.log',
        ],
        'template' => [

        ],
        'oauth' => [
            'scopes'   => ['snsapi_base'],
            'callback' => '/port/user/login',
        ],
    ],
    'tencent_cloud' => [
        'secret_id' => '',
        'secret_key' => '',
        'region' => '',
        'bucket' => '',
        'domain' => '',
    ],

    'site_info' => [
        'site_url' => 'http://leeadmin.com',
    ],
    'jwt' => [
        'key' => md5('leeadmin'),
        'exp' => 7200,
        'exp_refresh' => 1296000,
    ],
];
