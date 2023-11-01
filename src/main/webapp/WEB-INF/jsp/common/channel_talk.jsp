<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
  (function(){var w=window;if(w.ChannelIO){return w.console.error("ChannelIO script included twice.")}var ch=function(){ch.c(arguments)};ch.q=[];ch.c=function(args){ch.q.push(args)};w.ChannelIO=ch;function l(){if(w.ChannelIOInitialized){return}w.ChannelIOInitialized=true;var s=document.createElement("script");s.type="text/javascript";s.async=true;s.src="https://cdn.channel.io/plugin/ch-plugin-web.js";var x=document.getElementsByTagName("script")[0];if(x.parentNode){x.parentNode.insertBefore(s,x)}}if(document.readyState==="complete"){l()}else{w.addEventListener("DOMContentLoaded",l);w.addEventListener("load",l)}})();

  ChannelIO('boot', {
    "pluginKey": "8f96ca15-d09d-4434-b2fb-ace28cdfbfdb"
    , "mobileMessengerMode": "newTab"
	, "customLauncherSelector": ".channelTalk"
	, "hideChannelButtonOnBoot": true
    <c:if test="${!empty customProfileVO}">
	    ,"profile": {
	      	"name": "${customProfileVO.mbrNm}"
	      , "mobileNumber": "${customProfileVO.mblTelno}"
	      , "email": "${customProfileVO.eml}"
	      , "smsRcptnYn" : "${customProfileVO.smsRcptnYn}"
	      , "emlRcptnYn" : "${customProfileVO.emlRcptnYn}"
	      , "mbrConsltCnt" : ${customProfileVO.mbrConsltCnt}
	    }
    </c:if>
  });
</script>