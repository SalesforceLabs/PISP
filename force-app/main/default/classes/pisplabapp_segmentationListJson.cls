public class pisplabapp_segmentationListJson{
	public cls_rsp rsp;
	public class cls_rsp {
		public cls_result result;
		public String stat;	//ok
		public String version;	//1.0
	}
	public class cls_result {
		public String total_results;	//71
		public cls_lists lists;
	}
	public class cls_lists {
		public cls_list_x[] list_x;
	}
	public class cls_list_x {
		public String id;	//19959
		public String name;	//Customers
		public String is_public;	//false
		public String is_dynamic;	//false
		public String is_crm_visible;	//true
		public String created_at;	//2021-07-13 04:33:09
		public String updated_at;	//2021-07-13 04:33:10
	}
	public static pisplabapp_segmentationListJson parse(String json){
		return (pisplabapp_segmentationListJson) System.JSON.deserialize(json, pisplabapp_segmentationListJson.class);
	}
}