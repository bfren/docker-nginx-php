use bf

# Test PHP FPM configuration
export def test [] { { ^php-fpm -t } | bf handle conf/test | ignore }
