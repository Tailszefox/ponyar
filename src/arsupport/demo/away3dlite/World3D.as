package arsupport.demo.away3dlite 
{
	import arsupport.ARAway3DLiteCamera;

	import away3dlite.containers.Scene3D;
	import away3dlite.containers.View3D;
	import away3dlite.core.render.BasicRenderer;

	import ru.inspirit.asfeat.calibration.IntrinsicParameters;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author Eugene Zatepyakin
	 */
	public final class World3D extends Sprite 
	{
		public var view3d:View3D;
		public var camera3d:ARAway3DLiteCamera;
		public var scene3d:Scene3D;
		public var renderer:BasicRenderer;
		
		public var twilight:TwilightAR;
		public var rarity:RarityAR;
		public var pinkie:PinkieAR;
		public var apple:AppleAR;
		public var rainbow:RainbowAR;
		public var fluttershy:FluttershyAR;
        
		public function World3D(intrinsic:IntrinsicParameters, viewportW:int = 640, viewportH:int = 480)
		{
			scene3d = new Scene3D();
			renderer = new BasicRenderer();
			camera3d = new ARAway3DLiteCamera( intrinsic, 1.0 );
			
			view3d = new View3D(scene3d, camera3d, renderer);

			view3d.x = viewportW * 0.5;
			view3d.y = viewportH * 0.5;
			view3d.z = 0;
            
            this.addChild(view3d);
		}

        public function updateAROptions():void
        {
            camera3d.updateProjectionMatrix();
        }
		
		public function initTwilight():void
		{
			twilight = new TwilightAR(this);
            scene3d.addChild(twilight);
		}
		
		public function initRarity():void
		{
			rarity = new RarityAR(this);
			scene3d.addChild(rarity);
		}
		
		public function initPinkie():void
		{
			pinkie = new PinkieAR(this);
			scene3d.addChild(pinkie);
		}
		
		public function initApple():void
		{
			apple = new AppleAR(this);
			scene3d.addChild(apple);
		}
		
		public function initRainbow():void
		{
			rainbow = new RainbowAR(this);
			scene3d.addChild(rainbow);
		}
		
		public function initFluttershy():void
		{
			fluttershy = new FluttershyAR(this);
			scene3d.addChild(fluttershy);
		}
		
		public function render(e:Event = null):void
		{				
			view3d.render();
		}
	}
}
