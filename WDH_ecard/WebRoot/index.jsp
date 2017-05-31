<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html><!--声明当前文本的类型为html类型的-->
<html>
	<head>
		<!--声明当前页面编码集（中文编码<gbk,gb2312>,国际编码<utf-8>）-->
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta name="keywords" content="关键词，关键词">
		<meta name="description" content="">
		<title>Java打造微信扫一扫名片自动绑定系统_王东海</title><!--网页的一个标题-->
		<link rel="stylesheet" href="sg/css/animate.css">
		<style type="text/css">
			*{padding:0;margin:0;}/*解决浏览器之间不兼容的问题*/
			body{
				font-size: 12px;/*给我们的字体设置为12像素*/
				font-family: "微软雅黑";/*设置系统类型为：微软雅黑*/
				background:url(image/1.jpg) no-repeat;/*no-repeat：去除重复*/
				background-size: cover;/*background-size: cover：拉伸到适合浏览器的边框*/
			}
			/*ecardbox*/
			.ecardbox{
					width:600px;/*宽度*/
					margin: 120px  50px 0 100px;/*margin:外边距。移动边框距离浏览器的距离。默认为：上右下左*/
					float:left;/*向左浮动*/
			}
			h1{
				font-size: 30px;/*字体像素大小*/
				text-align: center;/*字体水平居中*/
				text-shadow: 2px 5px 10px #fff;/*设置文字阴影*/
			}
			.ecardbox p{
					float: left;
					background: #922f2f;
				    width: 280px;
				    height: 40px;
				    margin: 13px 8px;/*外边距：两个分别为：垂直和水平*/
				   line-height: 40px;/*行高*/
			}
			/*注意：
			 * 	span、img、a链接都是属于我们的行内元素。
			 * 而我们的p标签、div以及我们的h1标签呢，它是独占一行的，称之为一个块级元素。
			 * 块级元素你加宽度和高度它是有效果的。
			 * 而行内元素你加宽度和高度它是没有效果的，如果你也想让他的宽度和高度有效果的话，那么你就需要把它
			 * 提升为块级元素。
			 * 怎么将行内元素提升为块级元素？加一个：display: inline-block;
			 * */
			.ecardbox span{
					width: 60px;
					height: 40px;
					display: inline-block;/*提升为块级元素*/
					background: #cecec3;/*设置背景颜色*/
					text-align: center;/*将文字居中*/
					font-size: 14px;/*设置字体为14像素*/
    				font-weight: 700;/*字体变粗：默认为700*/
    				font-family: "楷体";/*设置字体类型*/
			}
			.ecardbox .input_text{
				width: 210px;
				height: 38px;
				background: #922f2f;
				outline: none;/*去掉蓝颜色*/
				border: 0;/*将边框变为0，就是说去掉边框*/
				text-indent: 16px;/*文字缩进，就是说不顶格写，给用户更好体验度*/
			}
			#btn{
				width: 580px;/*宽度*/
			    height: 40px;/*高度*/
			    margin-left: 6px;/*距离左边边距多少像素*/
			    font-size: 24px;/*字体大小*/
			    font-family: "楷体";/*字体类型*/
			    font-weight: 700;/*字体变粗，默认700*/
			    background: linear-gradient(#858594,#9e8888);/*背景颜色*/
			    outline: none;/*去掉蓝颜色*/
			    border: 0;/*去掉边框*/
			    cursor: pointer;/*鼠标放上面变为小手*/
			    border-radius: 6px;/*让上下左右边框直角变为圆角，这是css3里面的东西*/
			    color: #981515;/*设置字体颜色*/
			    transition: .5s;/*一个缓冲*/
			}
			/*hover:一个伪劣的事件*/
			#btn:hover{
				background: #515392;
				color: #fff;
			}
			/*ecardbox*/
		</style>
	</head> 
	<body>
		<!--ecardbox  start-->
		<div class="ecardbox">
			<h1>微信名片自动绑定系统—王东海</h1>
			<p><span>姓名: </span><input id="name" type="text" class="input_text"/></p>
			<p><span>公司: </span><input id="company" type="text" class="input_text"/></p>
			<p><span>部门: </span><input id="dept" type="text" class="input_text"/></p>
			<p><span>职务: </span><input id="title" type="text" class="input_text"/></p>
			<p><span>地址: </span><input id="address" type="text" class="input_text"/></p>
			<p><span>手机: </span><input id="tel" type="text" class="input_text"/></p>
			<p><span>邮箱: </span><input id="email" type="text" class="input_text"/></p>
			<p><span>网址: </span><input id="web" type="text" class="input_text"/></p>
			<input type="button" value="生成名片" id="btn"/>
		</div>
		<!--ecardbox  end-->
		
		<style>
			.imgBox{
				width:270px;
				height:200px;
				/* border:1px solid red; *//*加边框*/
				float:left;/*向左浮动*/
				margin:210px 0 0 20px;/*加一个外边距*/
			}
			.item{
				box-shadow:2px 5px 10px #111;/*加一个盒子阴影*/
				padding:10px;/*内边距*/
			}
		</style>
		<div class="imgBox">
			<!-- <div class="item animated rotateIn"><img src="image/qrcode.jpg"></div> -->
		</div>
		
		<!--引入js官方类库jQuery-->
		<script src="js/jquery-1.11.3.min.js"></script>
		<script>
			$(function(){
				$("#btn").click(function(){
					createCode();
				});
			});
			function createCode(){
				var name,company,title,address,tel,email,web,str;
				if($("#name").val()){
					name="FN:"+$("#name").val()+"\n";
				}else{
					name="";
				}
				if($("#title").val()){
					title="TITLE:"+$("#title").val()+"\n";
				}else{
					title="";
				}
				if($("#company").val()){
					if($("#dept").val()){
						company= "ORG:"+$("#company").val()+"("+$("#dept").val()+")"+"\n";
					}else{
						company= "ORG:"+$("#company").val()+"\n";
					}
				}else{
					company="";
				}
				if($("#address").val()){
					address="ADR;WORK:"+$("#address").val()+"\n";
				}else{
					address="";
				}
				if($("#tel").val()){
					tel="TEL;WORK:"+$("#tel").val()+"\n";
				}else{
					tel="";
				}
				if($("#email").val()){
					email="EMAIL;WORK:"+$("#email").val()+"\n";
				}else{
					email="";
				}
				if($("#web").val()){
					web="URL:"+$("#web").val()+"\n";
				}else{
					web="";
				}
				str = "BEGIN:VCARD\n"+name+company+title+address+tel+email+web+"END:VCARD";
				
				$(".imgBox").html("<div class='item animated rotateIn'><img id='imgqrde'/></div>");
				
				$.ajax({
					type:"post",
					url:"qrcode.jsp",
					data:{content:str},
					success:function(data){
						data = data.trim();
						$("#imgqrde").attr("src",data);
					}
				});
			};
		</script>
	</body>
</html>
