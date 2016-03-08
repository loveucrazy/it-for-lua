# it-for-lua
基于OR的简单web框架

# 0.02
1、application 下是应用目录，it 是框架目录，将 it 放在 /usr/local/openresty/lualib 下或在 http 中配置 it 的搜索路径即可。
2、实现了简单的 mvc 功能。
3、添加了 cookie 和 session 的操作，session 默认使用 redis。
4、将原有的单个配置文件拆分为多个。
5、数据库只添加了 postgresql 驱动


# 0.01
1、application 下是应用目录，it 是框架目录，将 it 放在 /usr/local/openresty/lualib 下或在 http 中配置 it 的搜索路径即可。
2、实现了简单的 mvc 功能。