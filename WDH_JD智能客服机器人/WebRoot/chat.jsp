<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>Java开发人工智能IM客服系统【京东IM核心技术】- 王东海</title>
		<meta name="keywords" content="关键词，关键词">
		<meta name="description" content="">
		
		<style type="text/css">
			*{margin:0; padding: 0;}
			body{
				background: url(images/211.jpg); 
				background-size: cover;
				font-size: 12px;
				font-family: "微软雅黑";
				color: #666;
			}
			/*char start：表示开始*/
 			.chat{
 				width: 900px;
 				height: 530px;
 				background: #f90;
 				margin: 100px auto;
 			}
 			.chat .c_top{
 				height: 68px;
 				background: #2d8ef2;
 				line-height: 68px;
 				font-size: 20px;
 				color: #fff;
 				padding-left: 15px;
 				padding-bottom: 10px;
 			}
 			.chat .c_con{
 				height: 380px;
 				background: #EFF0F2;
 				overflow:auto;
 			}
 			.chat .c_message{
 				height:82px;
 				background:#E3E3E3;
 			}
 			.chat .c_message .c_box{
 				width:770px;
 				height:52px;
 				background:#E8E8E8;
 				outline:none;
 				padding:15px;
 				font-size: 14px;
 				float: left;
 			}
 			/* #message{
 				width:798px;
 				height:80px;
 				border: 0;
 				outline: none;
 			} */
 			
 			.chat  .c_message  .c_btn  .c_sub{
 				float: right;
 				width:100px;
 				height: 82px;
 				border: none;
 				background: #ccc;
 				cursor: pointer;
 				outline: none;
 			}
 			
 			.chat .c_con .c_item{
 				height:50px;
 				width:880px;
 			}
 			.chat .c_con .c_left{
 				padding:10px 10px 0 10px;
 				float:left;
 			}
 			.chat .c_con .c_right{
 				padding:50px 10px 0 10px;
 				text-align:right;
 			}
 			.chat .c_con .c_right .c_name{
 				width:50px;
 				height:50px;
 				display:inline-block;
 			}
 			.chat .c_con .c_right .c_text{
 				margin-right:10px;
 			}
 			
 			/*设置自定义滚动条*/
			::-webkit-scrollbar{width:15px;}
			::-webkit-scrollbar-track{background-color:#bee1eb;}
			::-webkit-scrollbar-thumb{background-color:#00aff0;}
			::-webkit-scrollbar-thumb:hover {background-color:#9c3}
			::-webkit-scrollbar-thumb:active {background-color:#00aff0}
 			/*end chat：表示结束*/
		</style>
	</head>
	<body>
		<!--chat start-->
		<div class="chat" >
			<div class="c_top"><img src="images/top.png" alt="JiMi智能客服" width="535px" height="88px" style="margin: -20px 0 0 -13px"/></div>
			<div class="c_con">
				<div class="c_item c_left">
					<img src="images/1.png" alt="JiMi智能客服" width="50" height="50"/>&nbsp;&nbsp;
				</div>
			</div>
			<div class="c_message">
				<div class="c_box" contenteditable="true">
					<textarea  id="message" rows="4" cols="4" style="margin: 0px;
						width:800px;height:82px;
						border: 0;outline: none;
						margin:-15px 0 0 -15px;
						font-size: 14px;
						text-indent: 4px;
    					resize: none;">
    				</textarea>
				</div>
				<div class="c_btn">
					<input type="button"  value="发送" class="c_sub" id="c_sub_btn"/>
				</div>
			</div>
		</div>
		<!--end chat-->
		
		<!--引入jQuery官方类库-->
		<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
		<script type="text/javascript">
			$(function(){
				
				$("#c_sub_btn").click(function(){
					var value = $("#message").val();
					$(".c_con").append("<div class='c_item c_right'>"+
										"<span class='c_text'>"+value+":</span><span class='c_name'><img src='images/3.jpg' alt='JiMi智能客服' width='50' height='50'/></span>"+
										"</div>");
					$.ajax({
						type:"post",//请求类型
						url:"data.jsp",
						data:{info:value},
						success:function(data){
							var json = JSON.parse(data);
							$(".c_con").append("<div class='c_item c_left'>"+
											"<img src='images/1.png' alt='JiMi智能客服' width='50' height='50'/>&nbsp;&nbsp;"+json.text+"</div>");
							$("#message").val('');
						}
					});
				});
			});
		</script>
		
	</body>
</html>
