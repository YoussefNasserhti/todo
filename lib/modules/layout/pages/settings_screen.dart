import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import '../manager/main_provider.dart';

class SettingsScreen extends StatelessWidget {
    const SettingsScreen({super.key});

    @override
    Widget build(BuildContext context) {
        return Consumer<MainProvider>(
            builder: (context, provider, child) {
                return Scaffold(
                    body: Column(
                        children: [
                            Container(
                                height: 160,
                                color: Colors.blue,
                                padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    'settings'.tr(),
                                    style: GoogleFonts.poppins(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                    ),
                                ),
                            ),
                            Expanded(
                                child: Container(
                                    padding: const EdgeInsets.all(20),
                                    color: const Color(0xFFD7E7C9),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            Text(
                                                'language'.tr(),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                ),
                                            ),
                                            const SizedBox(height: 10),
                                            DropdownButtonFormField<String>(
                                                value: provider.language,
                                                items: <String>['English', 'Arabic']
                                                    .map((String value) {
                                                    return DropdownMenuItem<String>(
                                                        value: value,
                                                        child: Text(
                                                            value,
                                                            style: GoogleFonts.poppins(fontSize: 16),
                                                        ),
                                                    );
                                                }).toList(),
                                                onChanged: (newValue) {
                                                    if (newValue != null) {
                                                        provider.setLanguage(context, newValue);
                                                    }
                                                },
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    contentPadding: const EdgeInsets.symmetric(
                                                        vertical: 14,
                                                        horizontal: 15,
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                        borderSide: const BorderSide(color: Colors.blue),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                        borderSide: const BorderSide(color: Colors.blue),
                                                    ),
                                                ),
                                            ),
                                            const SizedBox(height: 30),
                                            Text(
                                                'mode'.tr(),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                ),
                                            ),
                                            const SizedBox(height: 10),
                                            DropdownButtonFormField<String>(
                                                value: provider.themeMode == ThemeMode.dark ? 'Dark' : 'Light',
                                                items: <String>['Light', 'Dark']
                                                    .map((String value) {
                                                    return DropdownMenuItem<String>(
                                                        value: value,
                                                        child: Text(
                                                            value,
                                                            style: GoogleFonts.poppins(fontSize: 16),
                                                        ),
                                                    );
                                                }).toList(),
                                                onChanged: (newValue) {
                                                    if (newValue != null) {
                                                        provider.setThemeMode(
                                                            newValue == 'Dark' ? ThemeMode.dark : ThemeMode.light
                                                        );
                                                    }
                                                },
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    contentPadding: const EdgeInsets.symmetric(
                                                        vertical: 14,
                                                        horizontal: 15,
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                        borderSide: const BorderSide(color: Colors.blue),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                        borderSide: const BorderSide(color: Colors.blue),
                                                    ),
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                            ),
                        ],
                    ),
                );
            },
        );
    }
}
