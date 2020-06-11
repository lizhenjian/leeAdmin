<?php
namespace app\util;
use Firebase\JWT\BeforeValidException;
use Firebase\JWT\ExpiredException;
use Firebase\JWT\JWT;
use Firebase\JWT\SignatureInvalidException;
use think\facade\Cache;
use think\facade\Request;

class JsonWebToken
{
    private $key = 'leeadmin';

    public function setKey($key)
    {
        $this->key = $key;
        return $this;
    }

    public function createToken($data)
    {
        $domain = Request::domain();
        $time = time();
        $data['iss'] = $domain;
        $data['aud'] = $domain;
        $data['iat'] = $time;
        $data['nbf'] = $time;
        $token = JWT::encode($data, $this->key);
        //服务器缓存jwtTOKEN
        cache('AccessToken:Jwt:' . $data['scopes'] .'-'. $data['user_id'], $data, $data['exp']);
        return $token;
    }

    public function checkToken($token)
    {

        try {
            $data = (array) JWT::decode($token, $this->key, array('HS256'));
            //校验服务器缓存jwtTOKEN
            $serviceToken = cache('AccessToken:Jwt:' . $data['scopes'].'-' .$data['user_id']);
            if(!$serviceToken){
                throw new ExpiredException('Token缓存过期，拒绝访问');
            }
            return $data;
        } catch (SignatureInvalidException $e) {
            throw new SignatureInvalidException('Token验证失败');
        } catch (BeforeValidException $e) {
            throw new BeforeValidException('无法处理Token');
        } catch (ExpiredException $e) {
            throw new ExpiredException('Token过期，拒绝访问');
        } catch (\Exception $e) {
            throw new \Exception('Token无效，拒绝访问');
        }
    }
}
