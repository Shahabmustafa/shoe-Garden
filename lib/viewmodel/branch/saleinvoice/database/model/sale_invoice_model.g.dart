// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_invoice_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SaleInvoiceModelLocalStorageAdapter
    extends TypeAdapter<SaleInvoiceModelLocalStorage> {
  @override
  final int typeId = 0;

  @override
  SaleInvoiceModelLocalStorage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SaleInvoiceModelLocalStorage(
      receivedAmount: fields[5] as String?,
      customerId: fields[0] as String?,
      saleMenId: fields[1] as String?,
      subTotal: fields[2] as String?,
      totalAmount: fields[3] as String?,
      invoiceNumber: fields[4] as String?,
      products: (fields[6] as List?)?.cast<InvoiceProducts>(),
    );
  }

  @override
  void write(BinaryWriter writer, SaleInvoiceModelLocalStorage obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.customerId)
      ..writeByte(1)
      ..write(obj.saleMenId)
      ..writeByte(2)
      ..write(obj.subTotal)
      ..writeByte(3)
      ..write(obj.totalAmount)
      ..writeByte(4)
      ..write(obj.invoiceNumber)
      ..writeByte(5)
      ..write(obj.receivedAmount)
      ..writeByte(6)
      ..write(obj.products);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaleInvoiceModelLocalStorageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class InvoiceProductsAdapter extends TypeAdapter<InvoiceProducts> {
  @override
  final int typeId = 1;

  @override
  InvoiceProducts read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InvoiceProducts(
      productId: fields[0] as String?,
      productName: fields[10] as String?,
      colorName: fields[11] as String?,
      sizeNumber: fields[12] as String?,
      companyId: fields[1] as String?,
      brandId: fields[2] as String?,
      typeId: fields[3] as String?,
      colorId: fields[4] as String?,
      sizeId: fields[5] as String?,
      quantity: fields[6] as String?,
      subTotal: fields[7] as String?,
      discount: fields[8] as String?,
      totalAmount: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, InvoiceProducts obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.companyId)
      ..writeByte(2)
      ..write(obj.brandId)
      ..writeByte(3)
      ..write(obj.typeId)
      ..writeByte(4)
      ..write(obj.colorId)
      ..writeByte(5)
      ..write(obj.sizeId)
      ..writeByte(6)
      ..write(obj.quantity)
      ..writeByte(7)
      ..write(obj.subTotal)
      ..writeByte(8)
      ..write(obj.discount)
      ..writeByte(9)
      ..write(obj.totalAmount)
      ..writeByte(10)
      ..write(obj.productName)
      ..writeByte(11)
      ..write(obj.colorName)
      ..writeByte(12)
      ..write(obj.sizeNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvoiceProductsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
