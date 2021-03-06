//
//  ShopRoutes.swift
//  Mixer
//
//  Created by Jack Cook on 1/9/16.
//  Copyright (c) 2017 Microsoft Corporation. All rights reserved.
//

/// Routes that can be used to interact with and retrieve shop data.
public class ShopRoutes {
    
    // MARK: Retrieving Shop Data
    
    /**
     Retrieves all shop categories.
    
     :param: completion An optional completion block with retrieved shop categories.
     */
    public func getCategories(_ completion: ((_ categories: [MixerShopCategory]?, _ error: MixerRequestError?) -> Void)?) {
        MixerRequest.request("/shop/categories") { (json, error) in
            guard let categories = json?.array else {
                completion?(nil, error)
                return
            }
            
            var retrievedCategories = [MixerShopCategory]()
            
            for category in categories {
                let retrievedCategory = MixerShopCategory(json: category)
                retrievedCategories.append(retrievedCategory)
            }
            
            completion?(retrievedCategories, error)
        }
    }
    
    /**
     Retrieves a shop item with a specific identifier.
     
     :param: itemId The identifier of the item being requested.
     :param: completion An optional completion block with the retrieved item's data.
     */
    public func getItemWithId(_ itemId: Int, completion: ((_ item: MixerShopItem?, _ error: MixerRequestError?) -> Void)?) {
        MixerRequest.request("/shop/items/\(itemId)") { (json, error) in
            guard let json = json else {
                completion?(nil, error)
                return
            }
            
            let item = MixerShopItem(json: json)
            completion?(item, error)
        }
    }
    
    /**
     Retrieves shop items in a specific category.
     
     :param: categoryId The identifier of the category with items that are being requested.
     :param: completion An optional completion block with the requested items' data.
     */
    public func getItemsByCategory(_ categoryId: Int, completion: ((_ items: [MixerShopItem]?, _ error: MixerRequestError?) -> Void)?) {
        MixerRequest.request("/shop/categories/\(categoryId)/items") { (json, error) in
            guard let items = json?.array else {
                completion?(nil, error)
                return
            }
            
            var retrievedItems = [MixerShopItem]()
            
            for item in items {
                let retrievedItem = MixerShopItem(json: item)
                retrievedItems.append(retrievedItem)
            }
            
            completion?(retrievedItems, error)
        }
    }
}
