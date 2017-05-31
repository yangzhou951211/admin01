package com.shsxt.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URI;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;

/**
 * 京东IM人工智能客服系统工具类
 * @author 王东海
 * @2016年11月20日
 * @version v1.0
 */
public class ChatUtil
{
	/**
	 * 对话智能客服系统获取答案
	 * @param messsage 用户输入问题信息
	 * @return String 智能客服回复的信息
	 */
	public static String getResult(String messsage)
	{
		StringBuffer buffer = new StringBuffer();
		
		try
		{
			//设置请求编码格式utf-8
			String question = URLEncoder.encode(messsage,"utf-8");
			//请求url对接图灵机器人的接口
			String requestUrl = "http://www.tuling123.com/openapi/api?"+"key=63fdf0cfc2fe4976a9fb04e14205617f&info="+question;
			//建立网络连接
			URL urlObj = new URL(requestUrl);
			//获取连接对象
			URLConnection connection = urlObj.openConnection();
			//直接连接
			connection.connect();
			
			//获取请求的结果
			InputStreamReader reader = new InputStreamReader(connection.getInputStream(),"utf-8");
			
			//建立缓冲流
			BufferedReader br = new BufferedReader(reader);
			
			String temp = null;
			while((temp = br.readLine()) != null)
			{
				buffer.append(temp);
			}
			//关闭流
			reader.close();
			br.close();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return buffer.toString();
		
	}
	
	//java入口
	public static void main(String[] args)
	{
		System.out.println("大家晚上好!");
		//调用图灵机器人大数据类库
		
		//建立文件流（缓冲流）
		
		//返回页面
	}
}
