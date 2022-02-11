wkhtmltopdf \
    --enable-local-file-access \
    --encoding utf-8 \
    --debug-javascript \
    --javascript-delay 3000 \
    --no-stop-slow-scripts \
    wk/area-stack.html ./one.pdf

docker run -v /root/wk_test/wk:/tmp/wk wkhtmltopdf:v1 wkhtmltopdf \
    --enable-local-file-access \
    --encoding utf-8 \
    --enable-javascript \
    --debug-javascript \
    --javascript-delay 1000 \
    --disable-smart-shrinking \
    --no-stop-slow-scripts \
    –-disable-smart-shrinking \
    # --dpi 300 \
    # --page-width 244mm \
    /tmp/wk/index.html  /tmp/wk/index.pdf 

docker run -v /root/wk_test/wk:/tmp/wk wkhtmltopdf:v1 wkhtmltopdf \
    --enable-local-file-access \
    --encoding utf-8 \
    --enable-javascript \
    --debug-javascript \
    --javascript-delay 1000 \
    --disable-smart-shrinking \
    --no-stop-slow-scripts \
    --dpi 300 \
    /tmp/wk/index.html  /tmp/wk/index.pdf 


docker build --no-cache -t wkhtmltopdf:v1 .