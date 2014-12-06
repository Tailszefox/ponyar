package arsupport.demo.away3dlite
{
	import arsupport.ARAway3DLiteContainer;
	import away3dlite.materials.Material;

	import away3dlite.core.base.Mesh;
	import away3dlite.core.base.Object3D;
	import away3dlite.containers.ObjectContainer3D;
	import away3dlite.core.utils.Cast;
	import away3dlite.loaders.Collada;
	import away3dlite.loaders.data.MaterialData;
	import away3dlite.materials.BitmapMaterial;
	
	import nochump.util.zip.*;
	import flash.utils.IDataInput;
	
	import flash.display.Bitmap;

	/**
	 * @author Eugene Zatepyakin
	 */
	public class TwilightAR extends ARAway3DLiteContainer
	{
		
		[Embed(source = "../../../../assets/twilight/twilight_body_2.png")] private static var bodyTexture:Class;
		[Embed(source = "../../../../assets/twilight/twilight_eyes_2.png")] private static var eyesTexture:Class;
		[Embed(source = "../../../../assets/twilight/twilight_hair_front.png")] private static var hairFrontTexture:Class;
		[Embed(source = "../../../../assets/twilight/twilight_hair_back.png")] private static var hairBackTexture:Class;
		[Embed(source = "../../../../assets/twilight/twilight_tail.png")] private static var tailTexture:Class;
		[Embed(source = "../../../../assets/twilight/twilight_horn.png")] private static var hornTexture:Class;
		
		[Embed(source = "../../../../assets/twilight/model.dae", mimeType = "application/octet-stream")] private static var Charmesh:Class;
		[Embed(source = "../../../../assets/twilight/model.zip", mimeType = "application/octet-stream")] private static var modelZip:Class;
		
		private var collada:Collada;
		private var model:ObjectContainer3D;
		
		private var bodyMaterial:BitmapMaterial;
		private var eyesMaterial:BitmapMaterial;
		private var hFrontMaterial:BitmapMaterial;
		private var hBackMaterial:BitmapMaterial;
		private var tailMaterial:BitmapMaterial;
		private var hornMaterial:BitmapMaterial;
		
		public var world3d:World3D;
		
		public function TwilightAR(world3d:World3D)
		{
			super();
			
			this.world3d = world3d;
			
			initObjects();
		}
		
		private function initObjects():void
		{
			
			collada = new Collada();
			collada.scaling = 30;
			
			var modelZipObject:Object = new modelZip();
			
			var zip:ZipFile = new ZipFile(modelZipObject as IDataInput);
			for each(var entry:ZipEntry in zip.entries)
			{
				model = collada.parseGeometry(zip.getInput(entry)) as ObjectContainer3D;
			}
			
			model.mouseEnabled = false;
			
			bodyMaterial = new BitmapMaterial(Bitmap(new bodyTexture()).bitmapData);
			eyesMaterial = new BitmapMaterial(Bitmap(new eyesTexture()).bitmapData);
			hFrontMaterial = new BitmapMaterial(Bitmap(new hairFrontTexture()).bitmapData);
			hBackMaterial = new BitmapMaterial(Bitmap(new hairBackTexture()).bitmapData);
			tailMaterial = new BitmapMaterial(Bitmap(new tailTexture()).bitmapData);
			hornMaterial = new BitmapMaterial(Bitmap(new hornTexture()).bitmapData);
			
			model.rotationX = -90;
			model.rotationZ = 90;
			
			model.materialLibrary.getMaterial("bodyMaterial-material").material = bodyMaterial;
			model.materialLibrary.getMaterial("eyesMaterial-material").material = eyesMaterial;
			model.materialLibrary.getMaterial("hornMaterial-material").material = hornMaterial;
			model.materialLibrary.getMaterial("hFrontMaterial-material").material = hFrontMaterial;
			model.materialLibrary.getMaterial("hBackMaterial-material").material = hBackMaterial;
			model.materialLibrary.getMaterial("tailMaterial-material").material = tailMaterial;
			
			this.addChild(model);
			
		}
	}
}
