<?php
declare (strict_types = 1);

namespace app\admin;

use think\App;
use think\Validate;
use think\facade\Session;
use think\exception\ValidateException;

/**
 * 控制器基础类
 */
abstract class BaseController
{
    /**
     * Request实例
     * @var \think\Request
     */
    protected $request;

    /**
     * 应用实例
     * @var \think\App
     */
    protected $app;

    /**
     * 是否批量验证
     * @var bool
     */
    protected $batchValidate = false;

    /**
     * 控制器中间件
     * @var array
     */
    protected $middleware = [];

    /**
     * 构造方法
     * @access public
     * @param  App  $app  应用对象
     */
    public function __construct(App $app)
    {
        $this->app     = $app;
        $this->request = $this->app->request;

        // 控制器初始化
        $this->initialize();
    }

    // 初始化
    protected function initialize()
    {
        $this->user  = Session::get('adminToken');
        $this->param = $this->request->param();
        // Session::delete('adminToken');
    }

    /**
     * 验证数据
     * @access protected
     * @param  array        $data     数据
     * @param  string|array $validate 验证器名或者验证规则数组
     * @param  array        $message  提示信息
     * @param  bool         $batch    是否批量验证
     * @return array|string|true
     * @throws ValidateException
     */
    protected function validate(array $data, $validate, array $message = [], bool $batch = false)
    {
        if (is_array($validate)) {
            $v = new Validate();
            $v->rule($validate);
        } else {
            if (strpos($validate, '.')) {
                // 支持场景
                list($validate, $scene) = explode('.', $validate);
            }
            $class = false !== strpos($validate, '\\') ? $validate : $this->app->parseClass('validate', $validate);
            $v     = new $class();
            if (!empty($scene)) {
                $v->scene($scene);
            }
        }

        $v->message($message);

        // 是否批量验证
        if ($batch || $this->batchValidate) {
            $v->batch(true);
        }

        try {
            $v->failException(true)->check($data);
        } catch (\Exception $e) {
            return json_result(202,$e->getMessage());
        }

        // 系统默认认为需要验证的表单同样需要验证令牌
        $this->checkFormToken();

        // return $v->failException(true)->check($data);
    }

    protected function checkFormToken()
    {
        $check = $this->request->checkToken('__token__', $this->request->param());

        if(false === $check) {
            return json_result(202, '令牌无效，请刷新页面');
        }

        // ...
    }
}
