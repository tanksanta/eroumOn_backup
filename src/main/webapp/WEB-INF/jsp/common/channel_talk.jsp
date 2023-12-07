<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
  (function(){var w=window;if(w.ChannelIO){return w.console.error("ChannelIO script included twice.")}var ch=function(){ch.c(arguments)};ch.q=[];ch.c=function(args){ch.q.push(args)};w.ChannelIO=ch;function l(){if(w.ChannelIOInitialized){return}w.ChannelIOInitialized=true;var s=document.createElement("script");s.type="text/javascript";s.async=true;s.src="https://cdn.channel.io/plugin/ch-plugin-web.js";var x=document.getElementsByTagName("script")[0];if(x.parentNode){x.parentNode.insertBefore(s,x)}}if(document.readyState==="complete"){l()}else{w.addEventListener("DOMContentLoaded",l);w.addEventListener("load",l)}})();

  ChannelIO('boot', {
    "pluginKey": "${talkPluginKey}"
    , "mobileMessengerMode": "newTab"
	, "customLauncherSelector": ".channelTalk"
	, "hideChannelButtonOnBoot": true
    <c:if test="${!empty customProfileVO}">
    	, "memberId": "${customProfileVO.memberId}"
    	, "memberHash": "${customProfileVO.memberHash}"
    	, "unsubscribeTexting" : ${customProfileVO.unsubscribeTexting}
    	, "unsubscribeEmail" : ${customProfileVO.unsubscribeEmail}
    	
	    ,"profile": {
	      "name": "${customProfileVO.mbrNm}"
	      , "mobileNumber": "${customProfileVO.mblTelno}"
	      , "email": "${customProfileVO.eml}"
	      , "mbrConsltCnt" : ${customProfileVO.mbrConsltCnt}
	      , "registerRecipient" : ${customProfileVO.registerRecipient}
	      , "existTestResult": "${customProfileVO.existTestResult}"
	   	  , "existLNumber": "${customProfileVO.existLNumber}"
	   	  , "existConslt": "${customProfileVO.existConslt}"
	   	  , "coupon": ${customProfileVO.coupon}
	    }
    </c:if>
  });
  
  
  <c:if test="${!empty channelTalkEvent}">
	//채널톡 event 처리
    ChannelIO('track', '${channelTalkEvent.eventName}', {
    	<c:forEach var="properyMap" items="${channelTalkEvent.propertyObj}" varStatus="status">
    		<c:if test="${status.index != 0}">,</c:if> ${properyMap.key} : "${properyMap.value}"
    	</c:forEach>
	});
  </c:if>
  
</script>