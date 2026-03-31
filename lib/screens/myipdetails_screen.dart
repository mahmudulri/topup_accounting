import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/myipcontroller.dart';
import '../models/ipdetails_model.dart';

class MyipdetailsScreen extends StatefulWidget {
  const MyipdetailsScreen({super.key});

  @override
  State<MyipdetailsScreen> createState() => _MyipdetailsScreenState();
}

class _MyipdetailsScreenState extends State<MyipdetailsScreen>
    with SingleTickerProviderStateMixin {
  final Myipcontroller controller = Get.put(Myipcontroller());
  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    controller.fethmyipdata(ip: "8.8.8.8");
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: _LoadingView());
        }

        final model = controller.myipdetails.value;
        if (model == null || model.ipData == null || model.ipData!.isEmpty) {
          return const Center(
            child: Text(
              "No Data Found",
              style: TextStyle(color: Color(0xFF9CA3AF)),
            ),
          );
        }

        final ip = model.ipData!.keys.first;
        final data = model.ipData![ip]!;

        return FadeTransition(
          opacity: _fadeAnim,
          child: CustomScrollView(
            slivers: [
              _buildSliverAppBar(ip, data),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: 16),
                    _SecurityBanner(detections: data.detections),
                    const SizedBox(height: 24),
                    _SectionHeader(
                      icon: Icons.router_rounded,
                      label: "Network",
                    ),
                    const SizedBox(height: 12),
                    _NetworkCard(network: data.network),
                    const SizedBox(height: 24),
                    _SectionHeader(
                      icon: Icons.location_on_rounded,
                      label: "Location",
                    ),
                    const SizedBox(height: 12),
                    _LocationCard(location: data.location),
                    const SizedBox(height: 24),
                    _SectionHeader(
                      icon: Icons.security_rounded,
                      label: "Security Flags",
                    ),
                    const SizedBox(height: 12),
                    _SecurityFlagsGrid(detections: data.detections),
                    const SizedBox(height: 24),
                    _SectionHeader(
                      icon: Icons.bar_chart_rounded,
                      label: "Risk Assessment",
                    ),
                    const SizedBox(height: 12),
                    _RiskCard(detections: data.detections),
                    const SizedBox(height: 24),
                    _SectionHeader(
                      icon: Icons.devices_rounded,
                      label: "Device Estimate",
                    ),
                    const SizedBox(height: 12),
                    _DeviceCard(device: data.deviceEstimate),
                    const SizedBox(height: 24),
                    _SectionHeader(
                      icon: Icons.update_rounded,
                      label: "Metadata",
                    ),
                    const SizedBox(height: 12),
                    _MetaCard(
                      lastUpdated: data.lastUpdated,
                      queryTime: model.queryTime,
                    ),
                  ]),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSliverAppBar(String ip, IpDetails data) {
    return SliverAppBar(
      expandedHeight: 260,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Light gradient background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFEFF6FF), Color(0xFFF5F7FA)],
                ),
              ),
            ),

            // Subtle decorative circle
            Positioned(
              top: -40,
              right: -40,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF2563EB).withOpacity(0.08),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2563EB).withOpacity(0.08),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFF2563EB).withOpacity(0.2),
                          ),
                        ),
                        child: const Icon(
                          Icons.language_rounded,
                          color: Color(0xFF2563EB),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "MY IP ADDRESS",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2563EB),
                              letterSpacing: 2,
                            ),
                          ),
                          Text(
                            ip,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF111827),
                              letterSpacing: 1,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      _PillBadge(
                        icon: Icons.flag_rounded,
                        label: data.location?.countryName ?? "Unknown",
                        color: const Color(0xFF7C3AED),
                      ),
                      const SizedBox(width: 8),
                      _PillBadge(
                        icon: Icons.wifi_rounded,
                        label: data.network?.type ?? "Unknown",
                        color: const Color(0xFF2563EB),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Search input field
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: Color(0xFF9CA3AF),
                          size: 18,
                        ),
                        const SizedBox(width: 8),

                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(
                              color: Color(0xFF111827),
                              fontSize: 14,
                            ),
                            decoration: const InputDecoration(
                              hintText: "Enter IP address...",
                              hintStyle: TextStyle(color: Color(0xFFD1D5DB)),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              controller.ipInput.value = value;
                            },
                            onSubmitted: (value) {
                              controller.fethmyipdata();
                            },
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            controller.fethmyipdata();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2563EB).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Color(0xFF2563EB),
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Loading ──────────────────────────────────────────────────────────────────

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 48,
          height: 48,
          child: CircularProgressIndicator(
            color: Color(0xFF2563EB),
            strokeWidth: 2,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Fetching IP Details...",
          style: TextStyle(
            color: const Color(0xFF6B7280).withOpacity(0.8),
            fontSize: 13,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}

// ── Shared widgets ────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String label;
  const _SectionHeader({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF2563EB), size: 18),
        const SizedBox(width: 8),
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2563EB),
            letterSpacing: 2,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF2563EB).withOpacity(0.25),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  const _GlassCard({required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _DataRow extends StatelessWidget {
  final String label;
  final String? value;
  final bool mono;
  const _DataRow({required this.label, this.value, this.mono = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value ?? "N/A",
              style: TextStyle(
                fontSize: 13,
                color: const Color(0xFF111827),
                fontWeight: FontWeight.w600,
                fontFamily: mono ? 'monospace' : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PillBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _PillBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Security Banner ──────────────────────────────────────────────────────────

class _SecurityBanner extends StatelessWidget {
  final Detections? detections;
  const _SecurityBanner({this.detections});

  @override
  Widget build(BuildContext context) {
    final risk = detections?.risk ?? 0;
    final isClean =
        risk == 0 &&
        detections?.proxy == false &&
        detections?.vpn == false &&
        detections?.tor == false;

    final color = isClean ? const Color(0xFF059669) : const Color(0xFFDC2626);
    final bgColor = isClean ? const Color(0xFFECFDF5) : const Color(0xFFFEF2F2);
    final borderColor = isClean
        ? const Color(0xFF6EE7B7)
        : const Color(0xFFFCA5A5);
    final icon = isClean ? Icons.verified_rounded : Icons.warning_rounded;
    final title = isClean ? "IP Looks Clean" : "Suspicious Activity Detected";
    final subtitle = isClean
        ? "No threats detected · Confidence ${detections?.confidence ?? 0}%"
        : "Risk Score: $risk · Review flags below";

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: color.withOpacity(0.75),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Network Card ─────────────────────────────────────────────────────────────

class _NetworkCard extends StatelessWidget {
  final Network? network;
  const _NetworkCard({this.network});

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Column(
        children: [
          _DataRow(label: "Organisation", value: network?.organisation),
          _divider(),
          _DataRow(label: "Hostname", value: network?.hostname, mono: true),
          _divider(),
          _DataRow(label: "Type", value: network?.type),
          _divider(),
          _DataRow(label: "ASN", value: network?.asn?.toString()),
          _divider(),
          _DataRow(label: "Range", value: network?.range?.toString()),
          _divider(),
          _DataRow(label: "Provider", value: network?.provider?.toString()),
        ],
      ),
    );
  }
}

// ── Location Card ─────────────────────────────────────────────────────────────

class _LocationCard extends StatelessWidget {
  final Location? location;
  const _LocationCard({this.location});

  @override
  Widget build(BuildContext context) {
    final lat = location?.latitude?.toStringAsFixed(4) ?? "N/A";
    final lon = location?.longitude?.toStringAsFixed(4) ?? "N/A";

    return _GlassCard(
      child: Column(
        children: [
          _DataRow(label: "Continent", value: location?.continentName),
          _divider(),
          _DataRow(label: "Country", value: location?.countryName),
          _divider(),
          _DataRow(label: "Country Code", value: location?.countryCode),
          _divider(),
          _DataRow(label: "Region", value: location?.regionName),
          _divider(),
          _DataRow(label: "City", value: location?.cityName),
          _divider(),
          _DataRow(
            label: "Postal Code",
            value: location?.postalCode?.toString(),
          ),
          _divider(),
          _DataRow(label: "Coordinates", value: "$lat° N, $lon° E", mono: true),
          _divider(),
          _DataRow(label: "Timezone", value: location?.timezone),
          _divider(),
          // Currency sub-section
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F3FF),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFDDD6FE)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "CURRENCY",
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF7C3AED),
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _CurrencyPill(
                      label: location?.currency?.name ?? "N/A",
                      sub: "Name",
                    ),
                    const SizedBox(width: 8),
                    _CurrencyPill(
                      label: location?.currency?.code ?? "N/A",
                      sub: "Code",
                    ),
                    const SizedBox(width: 8),
                    _CurrencyPill(
                      label: location?.currency?.symbol ?? "N/A",
                      sub: "Symbol",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CurrencyPill extends StatelessWidget {
  final String label;
  final String sub;
  const _CurrencyPill({required this.label, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFEDE9FE),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF4C1D95),
              ),
            ),
            Text(
              sub,
              style: const TextStyle(fontSize: 10, color: Color(0xFF7C3AED)),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Security Flags Grid ───────────────────────────────────────────────────────

class _SecurityFlagsGrid extends StatelessWidget {
  final Detections? detections;
  const _SecurityFlagsGrid({this.detections});

  @override
  Widget build(BuildContext context) {
    final flags = [
      {
        "label": "Proxy",
        "value": detections?.proxy ?? false,
        "icon": Icons.swap_horiz_rounded,
      },
      {
        "label": "VPN",
        "value": detections?.vpn ?? false,
        "icon": Icons.vpn_lock_rounded,
      },
      {
        "label": "TOR",
        "value": detections?.tor ?? false,
        "icon": Icons.circle_outlined,
      },
      {
        "label": "Hosting",
        "value": detections?.hosting ?? false,
        "icon": Icons.dns_rounded,
      },
      {
        "label": "Scraper",
        "value": detections?.scraper ?? false,
        "icon": Icons.code_rounded,
      },
      {
        "label": "Compromised",
        "value": detections?.compromised ?? false,
        "icon": Icons.bug_report_rounded,
      },
      {
        "label": "Anonymous",
        "value": detections?.anonymous ?? false,
        "icon": Icons.person_off_rounded,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.9,
      ),
      itemCount: flags.length,
      itemBuilder: (context, i) {
        final flag = flags[i];
        final isActive = flag["value"] as bool;
        final color = isActive
            ? const Color(0xFFDC2626)
            : const Color(0xFF059669);
        final bgColor = isActive
            ? const Color(0xFFFEF2F2)
            : const Color(0xFFECFDF5);
        final borderColor = isActive
            ? const Color(0xFFFCA5A5)
            : const Color(0xFF6EE7B7);

        return Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(flag["icon"] as IconData, color: color, size: 22),
              const SizedBox(height: 6),
              Text(
                flag["label"] as String,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF374151),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 2),
              Text(
                isActive ? "YES" : "NO",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: color,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Risk Card ─────────────────────────────────────────────────────────────────

class _RiskCard extends StatelessWidget {
  final Detections? detections;
  const _RiskCard({this.detections});

  @override
  Widget build(BuildContext context) {
    final risk = detections?.risk ?? 0;
    final confidence = detections?.confidence ?? 0;
    final firstSeen = detections?.firstSeen?.toString() ?? "N/A";
    final lastSeen = detections?.lastSeen?.toString() ?? "N/A";

    return _GlassCard(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _ScoreBox(
                  label: "RISK SCORE",
                  value: "$risk",
                  max: "/100",
                  color: risk == 0
                      ? const Color(0xFF059669)
                      : risk < 50
                      ? const Color(0xFFD97706)
                      : const Color(0xFFDC2626),
                  bgColor: risk == 0
                      ? const Color(0xFFECFDF5)
                      : risk < 50
                      ? const Color(0xFFFFFBEB)
                      : const Color(0xFFFEF2F2),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ScoreBox(
                  label: "CONFIDENCE",
                  value: "$confidence",
                  max: "%",
                  color: const Color(0xFF2563EB),
                  bgColor: const Color(0xFFEFF6FF),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _divider(),
          _DataRow(label: "First Seen", value: firstSeen),
          _divider(),
          _DataRow(label: "Last Seen", value: lastSeen),
        ],
      ),
    );
  }
}

class _ScoreBox extends StatelessWidget {
  final String label;
  final String value;
  final String max;
  final Color color;
  final Color bgColor;
  const _ScoreBox({
    required this.label,
    required this.value,
    required this.max,
    required this.color,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: color.withOpacity(0.8),
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: color,
                  height: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  max,
                  style: TextStyle(
                    fontSize: 14,
                    color: color.withOpacity(0.5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Device Card ───────────────────────────────────────────────────────────────

class _DeviceCard extends StatelessWidget {
  final DeviceEstimate? device;
  const _DeviceCard({this.device});

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Row(
        children: [
          Expanded(
            child: _DeviceStatBox(
              icon: Icons.devices_rounded,
              label: "Address Count",
              value: device?.address?.toString() ?? "N/A",
            ),
          ),
          Container(width: 1, height: 60, color: const Color(0xFFE5E7EB)),
          Expanded(
            child: _DeviceStatBox(
              icon: Icons.hub_rounded,
              label: "Subnet Devices",
              value: device?.subnet?.toString() ?? "N/A",
            ),
          ),
        ],
      ),
    );
  }
}

class _DeviceStatBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _DeviceStatBox({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF2563EB), size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF)),
        ),
      ],
    );
  }
}

// ── Meta Card ─────────────────────────────────────────────────────────────────

class _MetaCard extends StatelessWidget {
  final DateTime? lastUpdated;
  final int? queryTime;
  const _MetaCard({this.lastUpdated, this.queryTime});

  @override
  Widget build(BuildContext context) {
    final formattedDate = lastUpdated != null
        ? "${lastUpdated!.day.toString().padLeft(2, '0')} "
              "${_monthName(lastUpdated!.month)} ${lastUpdated!.year}  "
              "${lastUpdated!.hour.toString().padLeft(2, '0')}:${lastUpdated!.minute.toString().padLeft(2, '0')} UTC"
        : "N/A";

    return _GlassCard(
      child: Column(
        children: [
          _DataRow(label: "Last Updated", value: formattedDate),
          _divider(),
          _DataRow(
            label: "Query Time",
            value: queryTime != null ? "${queryTime}ms" : "N/A",
            mono: true,
          ),
        ],
      ),
    );
  }

  String _monthName(int m) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[m];
  }
}

// ── Divider ───────────────────────────────────────────────────────────────────

Widget _divider() => const Divider(color: Color(0xFFF3F4F6), height: 1);
