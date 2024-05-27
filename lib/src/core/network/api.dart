class Api {
  /// api config
  static const String _protocol = "https://";
  static const String _domain = "amarsolution.com/";
  static const String _apiEndPath = "api/";
  static const String _apiVersion = "v2/";

  static const String siteUrl = '$_protocol$_domain';
  static const String _baseUrl = '$_protocol$_domain$_apiEndPath$_apiVersion';

  /// auth
  static String get login => '${_baseUrl}login';
  static String get logout => '${_baseUrl}logout';
  static String get user => '${_baseUrl}user';

  /// products
  static String get productList => '${_baseUrl}products';
  static String get productListForDropDown => '${_baseUrl}pagination/products';
  static String productDetails(int productId) => '${_baseUrl}products/$productId';
  static String get addProduct => '${_baseUrl}products';
  static String updateProduct(int productId) => '${_baseUrl}products/$productId';
  static String deleteProduct(int productId) => '${_baseUrl}products/$productId';
  static String generateBarcode(int productId) => '${_baseUrl}products/generate/barcodes/$productId';
  static String updateVariant(int productId) => '${_baseUrl}products/barcodes/$productId';

  /// purchase
  static String get purchaseList => '${_baseUrl}purchase';
  static String purchaseDetails(int id) => '${_baseUrl}purchase/$id';
  static String get addPurchase => '${_baseUrl}purchase';
  static String updatePurchase(int id) => '${_baseUrl}purchase/$id';
  static String deletePurchase(int id) => '${_baseUrl}purchase/$id';

  /// purchase-return
  static String get purchaseReturnList => '${_baseUrl}purchase-return';
  static String purchaseReturnDetails(int id) => '${_baseUrl}purchase-return/$id';
  static String get addPurchaseReturn => '${_baseUrl}purchase-return';
  static String updatePurchaseReturn(int id) => '${_baseUrl}purchase-return/$id';
  static String deletePurchaseReturn(int id) => '${_baseUrl}purchase-return/$id';

  /// purchase-return-type
  static String get purchaseReturnTypeList => '${_baseUrl}purchase-return-type';
  static String get addPurchaseReturnType => '${_baseUrl}purchase-return-type';
  static String updatePurchaseReturnType(int id) => '${_baseUrl}purchase-return-type/$id';
  static String deletePurchaseReturnType(int id) => '${_baseUrl}purchase-return-type/$id';

  /// category
  static String get categoryList => '${_baseUrl}categories';
  static String get addCategory => '${_baseUrl}categories';
  static String updateCategory(int categoryId) => '${_baseUrl}categories/$categoryId';
  static String deleteCategory(int categoryId) => '${_baseUrl}categories/$categoryId';

  /// customer group
  static String get customerGroupList => '${_baseUrl}customer-groups';
  static String get addCustomerGroup => '${_baseUrl}customer-groups';
  static String updateCustomerGroup(int id) => '${_baseUrl}customer-groups/$id';
  static String deleteCustomerGroup(int id) => '${_baseUrl}customer-groups/$id';

  /// customer
  static String get customerList => '${_baseUrl}customers';
  static String get customerListWithSummary => '${_baseUrl}customers-summary';
  static String get customerListForDropDown => '${_baseUrl}pagination/customers';
  static String customerDetails(int customerId) => '${_baseUrl}customers/$customerId';
  static String get addCustomer => '${_baseUrl}customers';
  static String updateCustomer(int customerId) => '${_baseUrl}customers/$customerId';
  static String deleteCustomer(int customerId) => '${_baseUrl}customers/$customerId';
  static String customerLedger(int customerId) => '${_baseUrl}customers/$customerId/ledger';

  /// supplier
  static String get supplierList => '${_baseUrl}supplier';
  static String get supplierListWithSummary => '${_baseUrl}supplier-summary';
  static String get supplierListForDropDown => '${_baseUrl}pagination/suppliers';
  static String supplierDetails(int id) => '${_baseUrl}supplier/$id';
  static String supplierLedger(int id) => '${_baseUrl}supplier/$id/ledger';
  static String get addSupplier => '${_baseUrl}supplier';
  static String updateSupplier(int id) => '${_baseUrl}supplier/$id';
  static String deleteSupplier(int id) => '${_baseUrl}supplier/$id';

  /// brand
  static String get brandList => '${_baseUrl}brands';
  static String get addBrand => '${_baseUrl}brands';
  static String updateBrand(int brandId) => '${_baseUrl}brands/$brandId';
  static String deleteBrand(int brandId) => '${_baseUrl}brands/$brandId';

  /// area
  static String get areaList => '${_baseUrl}areas';
  static String get addArea => '${_baseUrl}areas';
  static String updateArea(int areaId) => '${_baseUrl}areas/$areaId';
  static String deleteArea(int areaId) => '${_baseUrl}areas/$areaId';

  /// product size
  static String get productSizeList => '${_baseUrl}sizes';
  static String get addProductSize => '${_baseUrl}sizes';
  static String updateProductSize(int sizeId) => '${_baseUrl}sizes/$sizeId';
  static String deleteProductSize(int sizeId) => '${_baseUrl}sizes/$sizeId';

  /// product color
  static String get productColorList => '${_baseUrl}colors';
  static String get addProductColor => '${_baseUrl}colors';
  static String updateProductColor(int colorId) => '${_baseUrl}colors/$colorId';
  static String deleteProductColor(int colorId) => '${_baseUrl}colors/$colorId';

  /// vat_group
  static String get vatGroupList => '${_baseUrl}vats';
  static String get addVatGroup => '${_baseUrl}vats';
  static String updateVatGroup(int vatId) => '${_baseUrl}vats/$vatId';
  static String deleteVatGroup(int vatId) => '${_baseUrl}vats/$vatId';

  /// units
  static String get unitList => '${_baseUrl}units';
  static String get addUnit => '${_baseUrl}units';
  static String updateUnit(int unitId) => '${_baseUrl}units/$unitId';
  static String deleteUnit(int unitId) => '${_baseUrl}units/$unitId';

  /// accounts
  static String get accountList => '${_baseUrl}accounts';
  static String accountDetails(int id) => '${_baseUrl}accounts/$id';

  /// user
  static String get userListForDropDown => '${_baseUrl}pagination/users';

  /// delivery-company
  static String get deliveryCompanyList => '${_baseUrl}delivery-companies';
  static String get addDeliveryCompany => '${_baseUrl}delivery-companies';
  static String updateDeliveryCompany(int id) => '${_baseUrl}delivery-companies/$id';
  static String deleteDeliveryCompany(int id) => '${_baseUrl}delivery-companies/$id';

  /// sales product
  static String get saleProduct => '${_baseUrl}sales';

  /// sales
  static String get salesList => '${_baseUrl}sales';
  static String salesDetails(int salesId) => '${_baseUrl}sales/$salesId';

  /// settings
  static String get businessSettings => '${_baseUrl}user-branch';
  static String get printSettings => '${_baseUrl}print-settings';

  /// stock
  static String get stockList => '${_baseUrl}stocks';
  static String stockDetails(int id) => '${_baseUrl}stocks/$id';
  static String stockLedger(int id) => '${_baseUrl}stocks/ledger/$id';

  /// exchange
  static String get exchange => '${_baseUrl}exchange/search/invoice';

  /// business
  static String get businessListForDropDown => '${_baseUrl}pagination/bussinesses';

  /// attribute-category
  static String get attributeCategories => '${_baseUrl}attribute-categories';

  /// attribute
  static String get attributes => '${_baseUrl}attribute';

  /// author
  static String get authorList => '${_baseUrl}author';
}
