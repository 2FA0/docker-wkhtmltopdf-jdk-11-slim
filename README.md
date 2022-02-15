### wkhtmltopdf内置jdk11
* 可直接在宿主机调用命令, 比如:
```bash
docker run -v /tmp/wk:/tmp/wk 2fa0/wkhtmltopdf:v1 
    --enable-local-file-access \
    --encoding utf-8 \
    --enable-javascript \
    --debug-javascript \
    --javascript-delay 1000 \
    --disable-smart-shrinking \
    --no-stop-slow-scripts \
    --dpi 300 \
    /tmp/wk/example.html  /tmp/wk/example.pdf 
```

* 也可作为基础镜像来用, 在java程序当中调用cmd, 例如:
```java
public class Example {
    private File toPdf(File html, String pdfFileAbsPath) throws IOException, InterruptedException {
        String cmd = String.format("wkhtmltopdf " +
                "    --enable-local-file-access " +
                "    --encoding utf-8 " +
                "    --debug-javascript " +
                "    --javascript-delay 2500 " +
                "    --dpi 300 " +
                "    --log-level warn " +
                "    --no-stop-slow-scripts  %s %s", html.getAbsolutePath(), pdfFileAbsPath);

        logger.info("show cmd -> {}", cmd);
        Process process = Runtime.getRuntime().exec(cmd, null);
        int exitValue = process.waitFor();

        // 打印控制台的常规和错误输出
        InputStream inputStream = process.getInputStream();
        byte[] data = new byte[1024];
        while (inputStream.read(data) != -1) {
            logger.info("output -> {}", new String(data, StandardCharsets.UTF_8));
        }

        InputStream errorStream = process.getErrorStream();
        while (errorStream.read(data) != -1) {
            logger.info("error -> {}", new String(data, StandardCharsets.UTF_8));
        }

        if (exitValue == 0) {
            return new File(pdfFileAbsPath);
        }
        throw new IOException("wkhtmltopdf调用出错, 看上边的日志");
    }
}
```