<?php

namespace app\api\middleware;

class ApiResponse {
    public function handle($request, \Closure $next) {
        return $next($request)->header(config('CROSS_DOMAIN'));
    }
}
