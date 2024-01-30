import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:status_saver/utils/domain/storedetails.dart';



class AppConstants {
  static var hivelangcode;

  static String FoldersFromWhatsapp="/WhatsApp/Media/.Statuses";
  static String WHATSAPP_PATH =
      "/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses";
  static String NewPath = "/storage/emulated/0/StatusSaver";

  static final List<String> options = [
    'English',
    'Hindi',
    'Arabic',
    'German',
    'Russian',
    'Spanish',
    'Urdu',
    'Japanese',
    'Italian'
  ];
  static final List<String> optionsCode = [
    'en',
    'hi',
    'ar',
    'de',
    'ru',
    'es',
    'ur',
    'ja',
    'it'
  ];
 static final Map<String, Map<String, String>> translations = {
  'en': {
    'appHeading': 'Status Saver',
    'general': 'General',
    'downloadAndShare': 'Download and share WhatsApp statuses',
    'darkMode': 'Dark Mode',
    'autoSave': 'Auto save',
    'about': 'About',
    'image': 'Image',
    'video': 'Video',
    'saved': 'Saved',
    'customtoast': 'Please Select the folder containing Whatsapp Media',
    'folderbutton': 'Select Folder',
    'permissionbutton': 'Allow Storage Permission',
    'folderbuttonmessage': 'Select the folder containing WhatsApp',
  },
  'hi': {
    'appHeading': 'स्थिति सेवर',
    'general': 'सामान्य',
    'downloadAndShare': 'WhatsApp स्थितियाँ डाउनलोड और साझा करें',
    'darkMode': 'डार्क मोड',
    'autoSave': 'ऑटो सेव',
    'about': 'बारे में',
    'image': 'छवि',
    'video': 'वीडियो',
    'saved': 'सहेजा गया',
    'customtoast': 'कृपया WhatsApp मीडिया वाले फ़ोल्डर को चुनें',
    'folderbutton': 'फ़ोल्डर का चयन करें',
    'permissionbutton': 'स्टोरेज अनुमति दें',
    'folderbuttonmessage': 'WhatsApp कोण्टेनिंग फ़ोल्डर का चयन करें',
  },
  'ar': {
    'appHeading': 'موفر الحالة',
    'general': 'عام',
    'downloadAndShare': 'تحميل ومشاركة حالات WhatsApp',
    'darkMode': 'الوضع الليلي',
    'autoSave': 'الحفظ التلقائي',
    'about': 'حول',
    'image': 'صورة',
    'video': 'فيديو',
    'saved': 'تم الحفظ',
    'customtoast': 'الرجاء تحديد المجلد الذي يحتوي على WhatsApp Media',
    'folderbutton': 'تحديد المجلد',
    'permissionbutton': 'السماح بإذن التخزين',
    'folderbuttonmessage': 'حدد المجلد الذي يحتوي على WhatsApp',
  },
  'de': {
    'appHeading': 'Status-Sparer',
    'general': 'Allgemein',
    'downloadAndShare': 'WhatsApp-Status herunterladen und teilen',
    'darkMode': 'Dunkler Modus',
    'autoSave': 'Automatisch speichern',
    'about': 'Über',
    'image': 'Bild',
    'video': 'Video',
    'saved': 'Gespeichert',
    'customtoast': 'Bitte wählen Sie den Ordner mit WhatsApp Media aus',
    'folderbutton': 'Ordner auswählen',
    'permissionbutton': 'Speicherberechtigung zulassen',
    'folderbuttonmessage': 'Wählen Sie den Ordner mit WhatsApp aus',
  },
  'ru': {
    'appHeading': 'Спасатель статуса',
    'general': 'Общее',
    'downloadAndShare': 'Скачивайте и делитесь статусами WhatsApp',
    'darkMode': 'Темный режим',
    'autoSave': 'Автоматическое сохранение',
    'about': 'О нас',
    'image': 'Изображение',
    'video': 'Видео',
    'saved': 'Сохранено',
    'customtoast': 'Пожалуйста, выберите папку с WhatsApp Media',
    'folderbutton': 'Выбрать папку',
    'permissionbutton': 'Разрешение на хранение',
    'folderbuttonmessage': 'Выберите папку с WhatsApp',
  },
  'es': {
    'appHeading': 'Ahorrador de estado',
    'general': 'General',
    'downloadAndShare': 'Descargar y compartir estados de WhatsApp',
    'darkMode': 'Modo oscuro',
    'autoSave': 'Guardado automático',
    'about': 'Acerca de',
    'image': 'Imagen',
    'video': 'Video',
    'saved': 'Guardado',
    'customtoast': 'Por favor, selecciona la carpeta que contiene WhatsApp Media',
    'folderbutton': 'Seleccionar carpeta',
    'permissionbutton': 'Permitir permisos de almacenamiento',
    'folderbuttonmessage': 'Selecciona la carpeta que contiene WhatsApp',
  },
  'ur': {
    'appHeading': 'حالت بچانے والا',
    'general': 'عام',
    'downloadAndShare': 'واٹس ایپ حالات ڈاؤن لوڈ اور شیئر کریں',
    'darkMode': 'ڈارک موڈ',
    'autoSave': 'آٹو سیو',
    'about': 'کے بارے میں',
    'image': 'تصویر',
    'video': 'ویڈیو',
    'saved': 'محفوظ',
    'customtoast': 'براہ کرم انتخاب کریں جو WhatsApp میڈیا شامل ہے',
    'folderbutton': 'فولڈر منتخب کریں',
    'permissionbutton': 'سٹوریج کی اجازت دیں',
    'folderbuttonmessage': 'واٹس ایپ شامل کرنے والے فولڈر کا انتخاب کریں',
  },
  'ja': {
    'appHeading': 'ステータスセーバー',
    'general': '一般',
    'downloadAndShare': 'WhatsAppのステータスをダウンロードして共有する',
    'darkMode': 'ダークモード',
    'autoSave': '自動保存',
    'about': '約',
    'image': '画像',
    'video': 'ビデオ',
    'saved': '保存済み',
    'customtoast': 'WhatsAppメディアを含むフォルダを選択してください',
    'folderbutton': 'フォルダを選択',
    'permissionbutton': 'ストレージ許可',
    'folderbuttonmessage': 'WhatsAppを含むフォルダを選択してください',
  },
  'it': {
    'appHeading': 'Risparmiatore di stato',
    'general': 'Generale',
    'downloadAndShare': 'Scarica e condividi gli stati di WhatsApp',
    'darkMode': 'Modalità scura',
    'autoSave': 'Salvataggio automatico',
    'about': 'Informazioni',
    'image': 'Immagine',
    'video': 'Video',
    'saved': 'Salvato',
    'customtoast': 'Seleziona la cartella che contiene WhatsApp Media',
    'folderbutton': 'Seleziona cartella',
    'permissionbutton': 'Consenti permessi di archiviazione',
    'folderbuttonmessage': 'Seleziona la cartella che contiene WhatsApp',
  },
  // Add translations for other languages as needed
};


  static data() {
    Box<Storedetails> dataBox = Hive.box<Storedetails>('DataBox');
    List<Storedetails> datmodelList = dataBox.values.toList();
    log(datmodelList.toString());
    for (var storedetails in datmodelList) {
      log('Element: ${storedetails.lang}, ${storedetails.mode}');

      hivelangcode = storedetails.lang;
    }
    return hivelangcode ?? "en";
  }



}

const TextStyle textStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w700,
  color: Colors.green,
);
