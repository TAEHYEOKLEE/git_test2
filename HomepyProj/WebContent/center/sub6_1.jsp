<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="utf-8" />
<title>NAVER 지도 tm128 타입 좌표 찍기</title>
</head>
<body>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=mR4xhxAifFxfWqHTRWit&submodules=geocoder"></script>
<div id="map" style="width:100%;height:400px;"></div>
<script>
   var map = null, infoWindow = null;

   function initMap() {
      map = new naver.maps.Map("map", {
		
    	 //tm128타입 좌표
         center : new naver.maps.Point(301271, 542742),
 
         
         zoom : 8,
         mapTypes : new naver.maps.MapTypeRegistry({
        	//일반지도
            'normal' : naver.maps.NaverMapTypeOption.getNormalMap({
               projection : naver.maps.TM128Coord
            }),
            //지형도
            'terrain' : naver.maps.NaverMapTypeOption.getTerrainMap({
               projection : naver.maps.TM128Coord
            }),
            //위성지도
            'satellite' : naver.maps.NaverMapTypeOption
                  .getSatelliteMap({
                     projection : naver.maps.TM128Coord
                  }),
             //겹쳐보기
            'hybrid' : naver.maps.NaverMapTypeOption.getHybridMap({
               projection : naver.maps.TM128Coord
            })
         }),
         mapTypeControl : true;
      });

      infoWindow = new naver.maps.InfoWindow({
         content : getInfoWindowContent(map.getCenter())
      });
	  
      //말풍선 띄워주는 함수
      function updateInfoWindow(coord) {
         infoWindow.setContent(getInfoWindowContent(coord));
         infoWindow.open(map, coord);
      }

      function getInfoWindowContent(coord) {
         console.log('Coord:', coord);
         
       return [
          '<div style="padding:10px;width:200px;font-size:14px;line-height:20px;text-align:center;">',
          '<p>',
          '<strong>Coord</strong> : ' + 'TM128 좌표' + '<br />',
          '</p>', '</div>' ].join('');
      }

      updateInfoWindow(map.getCenter());

      map.addListener('idle', function(e) {
         updateInfoWindow(map.getCenter());
      });
   }

   naver.maps.onJSContentLoaded = initMap;
</script>
</body>
</html>
