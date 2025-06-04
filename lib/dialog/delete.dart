import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

/// Menampilkan dialog konfirmasi hapus.
///
/// Mengembalikan `true` jika pengguna menekan tombol "hapus",
/// `false` atau `null` jika batal.
Future<bool?> showConfirmDeleteDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('konfirmasi_hapus'.tr()),
        content: Text('yakin_hapus_item_ini'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('batal'.tr()),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'hapus'.tr(),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}
