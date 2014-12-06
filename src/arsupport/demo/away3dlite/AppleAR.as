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
	public class AppleAR extends ARAway3DLiteContainer
	{
		
		[Embed(source = "../../../../assets/applejack/applejack_body.png")] private static var bodyTexture:Class;
		[Embed(source = "../../../../assets/applejack/applejack_eyes.png")] private static var eyesTexture:Class;
		[Embed(source = "../../../../assets/applejack/applejack_hair_front.png")] private static var hairFrontTexture:Class;
		[Embed(source = "../../../../assets/applejack/applejack_hat.png")] private static var hatTexture:Class;
		[Embed(source = "../../../../assets/applejack/applejack_hair_back_upper.png")] private static var hairUpTexture:Class;
		[Embed(source = "../../../../assets/applejack/applejack_hair_back_lower.png")] private static var hairDownTexture:Class;
		[Embed(source = "../../../../assets/applejack/applejack_tail_upper.png")] private static var tailUpTexture:Class;
		[Embed(source = "../../../../assets/applejack/applejack_tail_lower.png")] private static var tailDownTexture:Class;
		[Embed(source = "../../../../assets/applejack/applejack_hairband.png")] private static var headbandTexture:Class;
		
		//[Embed(source="../../../../assets/applejack/model.dae", mimeType="application/octet-stream")] private static var Charmesh:Class;
		[Embed(source = "../../../../assets/applejack/model.zip", mimeType = "application/octet-stream")] private static var modelZip:Class;
			
		private var collada:Collada;
		private var model:ObjectContainer3D;
		
		private var bodyMaterial:BitmapMaterial;
		private var eyesMaterial:BitmapMaterial;
		private var hairFrontMaterial:BitmapMaterial;
		private var hatMaterial:BitmapMaterial;
		private var hairUpMaterial:BitmapMaterial;
		private var hairDownMaterial:BitmapMaterial;
		private var tailUpMaterial:BitmapMaterial;
		private var tailDownMaterial:BitmapMaterial;
		private var headbandMaterial:BitmapMaterial;
		
		public var world3d:World3D;
		
		public function AppleAR(world3d:World3D)
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
			hairFrontMaterial = new BitmapMaterial(Bitmap(new hairFrontTexture()).bitmapData);
			hatMaterial = new BitmapMaterial(Bitmap(new hatTexture()).bitmapData);
			hairUpMaterial = new BitmapMaterial(Bitmap(new hairUpTexture()).bitmapData);
			hairDownMaterial = new BitmapMaterial(Bitmap(new hairDownTexture()).bitmapData);
			tailUpMaterial = new BitmapMaterial(Bitmap(new tailUpTexture()).bitmapData);
			tailDownMaterial = new BitmapMaterial(Bitmap(new tailDownTexture()).bitmapData);
			headbandMaterial = new BitmapMaterial(Bitmap(new headbandTexture()).bitmapData);
        	
			model.rotationX = -90;
			model.rotationZ = 90;
			
			model.materialLibrary.getMaterial("bodyMaterial-material").material = bodyMaterial;
			model.materialLibrary.getMaterial("eyesMaterial-material").material = eyesMaterial;
			model.materialLibrary.getMaterial("hFrontMaterial-material").material = hairFrontMaterial;
			model.materialLibrary.getMaterial("hatMaterial-material").material = hatMaterial;
			model.materialLibrary.getMaterial("hBackupMaterial-material").material = hairUpMaterial;
			model.materialLibrary.getMaterial("hairBackdownMaterial-material").material = hairDownMaterial;
			model.materialLibrary.getMaterial("tailUpperMaterial-material").material = tailUpMaterial;
			model.materialLibrary.getMaterial("tailLowerMaterial-material").material = tailDownMaterial;
			model.materialLibrary.getMaterial("hairbandFrontMaterial-material").material = headbandMaterial;
			model.materialLibrary.getMaterial("hairbandTailMaterial-material").material = headbandMaterial;
			
			this.addChild(model);
			
		}
	}
}
