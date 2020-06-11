<?php

return [
	//开启session中间件
	'think\middleware\SessionInit',
	//验证管理员操作权限
	\app\admin\middleware\Auth::class,
	\app\admin\middleware\AdminLog::class,
];
