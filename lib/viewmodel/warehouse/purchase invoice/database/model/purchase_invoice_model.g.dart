// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_invoice_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PurchaseInvoiceLocalStorageModelAdapter
    extends TypeAdapter<PurchaseInvoiceLocalStorageModel> {
  @override
  final int typeId = 2;

  @override
  PurchaseInvoiceLocalStorageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PurchaseInvoiceLocalStorageModel(
      companyId: fields[0] as String?,
      subTotal: fields[1] as String?,
      totalAmount: fields[2] as String?,
      invoiceNumber: fields[3] as String?,
      products: (fields[4] as List?)?.cast<PurchaseModel>(),
      receivedAmount: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PurchaseInvoiceLocalStorageModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.companyId)
      ..writeByte(1)
      ..write(obj.subTotal)
      ..writeByte(2)
      ..write(obj.totalAmount)
      ..writeByte(3)
      ..write(obj.invoiceNumber)
      ..writeByte(4)
      ..write(obj.products)
      ..writeByte(5)
      ..write(obj.receivedAmount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PurchaseInvoiceLocalStorageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PurchaseModelAdapter extends TypeAdapter<PurchaseModel> {
  @override
  final int typeId = 3;

  @override
  PurchaseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PurchaseModel(
      productId: fields[0] as String?,
      productName: fields[10] as String?,
      sizeNumber: fields[12] as String?,
      colorName: fields[11] as String?,
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
  void write(BinaryWriter writer, PurchaseModel obj) {
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
      other is PurchaseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
