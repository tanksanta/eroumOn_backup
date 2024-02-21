<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

  <div class="wrapper align_center">

    <header>

    </header>

    <div class="center">
        <div style="background-color: #FF8120;width:80px;height:80px;border-radius: 50%; display: inline-block;"></div>
        <div class="h16"></div>
        <p class="color_t_p font_shm"></p>
    </div>

  </div>
  <!-- wrapper -->
  
  
  <script>
  	$(function() {
  		//메세지 넣기 html로
  		var msgHtml = '${msg}';
  		var decoded = $("<div/>").html(msgHtml).text();
  		$('.color_t_p').html(decoded);
  		
  		setTimeout(function() {
  			location.replace(decodeURI('${redirectUrl}').replaceAll("&amp;", "&"));
  		}, 3000);
  	})
  </script>