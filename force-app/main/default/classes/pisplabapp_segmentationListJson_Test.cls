@isTest
private class pisplabapp_segmentationListJson_Test {
    static testMethod void testParse() {
		String json=		'{'+
		'	"rsp": {'+
		'		"result": {'+
		'			"total_results": "71",'+
		'			"lists": {'+
		'				"list": [{'+
		'					"id": "19959",'+
		'					"name": "Customers",'+
		'					"is_public": "false",'+
		'					"is_dynamic": "false",'+
		'					"is_crm_visible": "true",'+
		'					"created_at": "2021-07-13 04:33:09",'+
		'					"updated_at": "2021-07-13 04:33:10"'+
		'				}, {'+
		'					"id": "19961",'+
		'					"name": "Partners",'+
		'					"is_public": "false",'+
		'					"is_dynamic": "false",'+
		'					"is_crm_visible": "true",'+
		'					"created_at": "2021-07-13 04:33:09",'+
		'					"updated_at": "2021-07-13 04:33:10"'+
		'				}, {'+
		'					"id": "19963",'+
		'					"name": "Monthly Newsletter",'+
		'					"is_public": "false",'+
		'					"is_dynamic": "false",'+
		'					"is_crm_visible": "true",'+
		'					"created_at": "2021-07-13 04:33:09",'+
		'					"updated_at": "2021-07-13 04:33:10"'+
		'				}]'+
		'			}'+
		'		},'+
		'		"stat": "ok",'+
		'		"version": "1.0"'+
		'	}'+
		'}';
		pisplabapp_segmentationListJson obj = pisplabapp_segmentationListJson.parse(json);
		System.assert(obj != null);
	}
    static testMethod void testParse_singleList() {
		String json=		'{'+
		'	"rsp": {'+
		'		"result": {'+
		'			"total_results": "70",'+
		'			"lists": {'+
		'				"list": [{'+
		'					"id": "19959",'+
		'					"name": "Customers",'+
		'					"is_public": "false",'+
		'					"is_dynamic": "false",'+
		'					"is_crm_visible": "true",'+
		'					"created_at": "2021-07-12 04:33:09",'+
		'					"updated_at": "2021-07-12 04:33:10"'+
		'				}]'+
		'			}'+
		'		},'+
		'		"stat": "ok",'+
		'		"version": "1.0"'+
		'	}'+
		'}';
		pisplabapp_segmentationListJson obj = pisplabapp_segmentationListJson.parse(json);
		System.assert(obj != null);
	}
}