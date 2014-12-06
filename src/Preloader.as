package 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.utils.getDefinitionByName;
	
	import flash.text.TextField;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author Tailszefox
	 */
	public class Preloader extends MovieClip 
	{
		private var bar:Sprite;
		private var txtLoading:TextField;
		private var txtLoading2:TextField;
		private var bgshape:Sprite;
		
		public function Preloader() 
		{
			if (stage) {
				stage.scaleMode = StageScaleMode.SHOW_ALL;
				//stage.align = StageAlign.TOP;
			}
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			bgshape = new Sprite();
			bgshape.graphics.beginFill(0x000000);
			bgshape.graphics.drawRect(0,0,stage.stageWidth, stage.stageHeight);
			addChildAt(bgshape, 0);
			stage.addEventListener(Event.RESIZE, resizeBGWithStage);			
			
			bar = new Sprite();
			bar.graphics.lineStyle(1, 0x4444ff, 1, true);
			bar.graphics.drawRect(0, 0, 200, 20);
			bar.x = stage.stageWidth / 2 - bar.width / 2;
			bar.y = stage.stageHeight / 2 - bar.height / 2;
			addChild(bar);
			
			var txtLoadingFormat:TextFormat = new TextFormat();
			txtLoadingFormat.align = TextFormatAlign.CENTER;
			txtLoadingFormat.size = 20;
			txtLoadingFormat.font = "Arial";
			txtLoadingFormat.color = 0xffffff;
			
			txtLoading = new TextField();
			txtLoading.defaultTextFormat = txtLoadingFormat;
			txtLoading.width = stage.stageWidth;
			txtLoading.y = 190;
			txtLoading.text = "Loading ponies...";
			addChild(txtLoading);
			
			txtLoading2 = new TextField();
			txtLoading2.defaultTextFormat = txtLoadingFormat;
			txtLoading2.width = stage.stageWidth;
			txtLoading2.y = 300;
			txtLoading2.text = "Get your marker ready!";
			addChild(txtLoading2);
		}
		
		private function ioError(e:IOErrorEvent):void 
		{
			trace(e.text);
		}
		
		private function progress(e:ProgressEvent):void 
		{
			bar.graphics.lineStyle(0, 0, 0);
			bar.graphics.beginFill(0x8888ff);
			bar.graphics.drawRect(1, 1, (e.bytesLoaded / e.bytesTotal) * 198 , 18);
			bar.graphics.endFill();
		}
		
		private function checkFrame(e:Event):void 
		{
			if (currentFrame == totalFrames) 
			{
				stop();
				loadingFinished();
			}
		}
		
		private function loadingFinished():void 
		{
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			removeChild(bar);
			bar = null;
			
			removeChild(txtLoading);
			txtLoading = null;
			
			removeChild(txtLoading2);
			txtLoading2 = null;
			
			removeChild(bgshape);
			bgshape = null;
			
			startup();
		}
		
		private function startup():void 
		{
			var mainClass:Class = getDefinitionByName("Main") as Class;
			addChild(new mainClass() as DisplayObject);
		}
		
		private function resizeBGWithStage(e:Event):void
		{
			try {
				bgshape.width = stage.stageWidth;
				bgshape.height = stage.stageHeight;
			} catch(e:Event){}
		}
	}
	
}