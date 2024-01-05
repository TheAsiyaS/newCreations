import 'package:carousel_slider/carousel_slider.dart'; 
import 'package:flutter/material.dart'; 


class carouselSlider extends StatelessWidget {
  const carouselSlider({super.key});
 
@override 
Widget build(BuildContext context) { 
	return Scaffold( 
	appBar: AppBar( 
		title: const Text("GFG Slider"), 
	), 
	body: ListView( 
		children: [ 
		CarouselSlider( 
			items: [ 
				
				//1st Image of Slider 
				Container( 
				margin:const EdgeInsets.all(6.0), 
				decoration: BoxDecoration( 
					borderRadius: BorderRadius.circular(8.0), 
					image:const DecorationImage( 
					image: NetworkImage("https://archello.s3.eu-central-1.amazonaws.com/images/2018/02/21/ModernLuxuryCEOOfficeInteriorDesign1.1519240126.0188.jpg"), 
					fit: BoxFit.cover, 
					), 
				), 
				), 
				
				//2nd Image of Slider 
				Container( 
				margin:const EdgeInsets.all(6.0), 
				decoration: BoxDecoration( 
					borderRadius: BorderRadius.circular(8.0), 
					image:const DecorationImage( 
					image: NetworkImage("https://officebanao.com/wp-content/uploads/2023/09/4-4-1024x576.jpg"), 
					fit: BoxFit.cover, 
					), 
				), 
				), 
				
				//3rd Image of Slider 
				Container( 
				margin:const EdgeInsets.all(6.0), 
				decoration: BoxDecoration( 
					borderRadius: BorderRadius.circular(8.0), 
					image:const DecorationImage( 
					image: NetworkImage("https://static.wixstatic.com/media/bdf5a9_82c9bec502e94864a1e64fad77fb9533.jpg/v1/fill/w_1866,h_1050,al_c/bdf5a9_82c9bec502e94864a1e64fad77fb9533.jpg"), 
					fit: BoxFit.cover, 
					), 
				), 
				), 
				
				//4th Image of Slider 
				Container( 
				margin:const EdgeInsets.all(6.0), 
				decoration: BoxDecoration( 
					borderRadius: BorderRadius.circular(8.0), 
					image:const DecorationImage( 
					image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQc4sFdCzkGAqRYxYchjZTNO8vOXkIjAkXb-f0NWaWbrW735yQ_G9L-VAfXIVlB5Csy2oo&usqp=CAU"), 
					fit: BoxFit.cover, 
					), 
				), 
				), 
				
				//5th Image of Slider 
				Container( 
				margin:const EdgeInsets.all(6.0), 
				decoration: BoxDecoration( 
					borderRadius: BorderRadius.circular(8.0), 
					image:const DecorationImage( 
					image: NetworkImage("https://static1.bigstockphoto.com/8/3/4/large1500/438747719.jpg"), 
					fit: BoxFit.cover, 
					), 
				), 
				), 

		], 
			
			//Slider Container properties 
			options: CarouselOptions( 
				height: 180.0, 
				enlargeCenterPage: true, 
				autoPlay: true, 
				aspectRatio: 16 / 9, 
				autoPlayCurve: Curves.fastOutSlowIn, 
				enableInfiniteScroll: true, 
				autoPlayAnimationDuration:const Duration(milliseconds: 800), 
				viewportFraction: 0.8, 
			), 
		), 
		], 
	), 

	); 
} 
}
