<%@ page import="com.alipay.api.response.AlipayTradeWapPayResponse" %>
<%@ page import="com.alipay.api.AlipayClient" %>
<%@ page import="com.alipay.api.DefaultAlipayClient" %>
<%@ page import="com.alipay.api.request.AlipayTradeWapPayRequest" %>
<%@ page import="scuxiaoer.AlipayConfig" %><%--
  Created by IntelliJ IDEA.
  User: duanqifeng
  Date: 2019/2/23
  Time: 10:37 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>alipay-phone</title>
</head>
<body>

<%
    AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.gatewayUrl, AlipayConfig.app_id, AlipayConfig.merchant_private_key, "json", AlipayConfig.charset, AlipayConfig.alipay_public_key, AlipayConfig.sign_type);
    AlipayTradeWapPayRequest Alirequest = new AlipayTradeWapPayRequest();
    Alirequest.setReturnUrl(AlipayConfig.return_url);
    Alirequest.setNotifyUrl(AlipayConfig.notify_url);

    //商户订单号，商户网站订单系统中唯一订单号，必填
    String out_trade_no = String.valueOf(System.currentTimeMillis());
    //付款金额，必填
    String total_amount = "1";
    //订单名称，必填
    String subject = "取件费用";
    //商品描述，可空
    String body = "帮忙取快递的费用";

    Alirequest.setBizContent("{\"out_trade_no\":\""+ out_trade_no +"\","
            + "\"total_amount\":\""+ total_amount +"\","
            + "\"subject\":\""+ subject +"\","
            + "\"body\":\""+ body +"\","
            + "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");

    AlipayTradeWapPayResponse Aliresponse = alipayClient.pageExecute(Alirequest);
    if(Aliresponse.isSuccess()){
        System.out.println("调用成功");
        String result = Aliresponse.getBody();
        out.print(result);
    } else {
        System.out.println("调用失败");
    }

%>


</body>
</html>
