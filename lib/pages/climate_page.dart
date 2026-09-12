import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:svg_flutter/svg.dart';

/// Climate control page — adjust temperature, fan, and seat heating.
class ClimatePage extends StatefulWidget {
  const ClimatePage({super.key});

  @override
  State<ClimatePage> createState() => _ClimatePageState();
}

class _ClimatePageState extends State<ClimatePage> {
  double _temperature = 72.0;
  int _fanSpeed = 3;
  bool _isACOn = true;
  bool _isHeatedSeatsOn = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Temperature Display ──
          _buildTemperatureCard(),
          const SizedBox(height: 20),

          // ── Climate Controls ──
          Row(
            children: [
              Expanded(
                child: _buildToggleCard(
                  icon: 'assets/icons/coolShape.svg',
                  label: 'A/C',
                  isActive: _isACOn,
                  onTap: () => setState(() => _isACOn = !_isACOn),
                  activeColor: Colors.cyan,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildToggleCard(
                  icon: 'assets/icons/Temp.svg',
                  label: 'Fan: $_fanSpeed',
                  isActive: _fanSpeed > 0,
                  onTap: () =>
                      setState(() => _fanSpeed = (_fanSpeed + 1) % 5),
                  activeColor: Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildToggleCard(
                  icon: 'assets/icons/heatShape.svg',
                  label: 'Seats',
                  isActive: _isHeatedSeatsOn,
                  onTap: () =>
                      setState(() => _isHeatedSeatsOn = !_isHeatedSeatsOn),
                  activeColor: Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ── Temperature Slider ──
          _buildSliderCard(),
        ],
      ),
    );
  }

  Widget _buildTemperatureCard() {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTempButton(
            icon: Icons.remove,
            onTap: () => setState(
                () => _temperature = (_temperature - 1).clamp(60.0, 85.0)),
          ),
          const SizedBox(width: 24),
          Column(
            children: [
              Text(
                '${_temperature.round()}°',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 56,
                  fontWeight: FontWeight.w200,
                ),
              ),
              Text(
                'Fahrenheit',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(width: 24),
          _buildTempButton(
            icon: Icons.add,
            onTap: () => setState(
                () => _temperature = (_temperature + 1).clamp(60.0, 85.0)),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderCard() {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: Colors.cyan.shade300,
              inactiveTrackColor: Colors.white.withValues(alpha: 0.1),
              thumbColor: Colors.white,
              overlayColor: Colors.cyan.withValues(alpha: 0.2),
              trackHeight: 4,
              thumbShape:
                  const RoundSliderThumbShape(enabledThumbRadius: 8),
            ),
            child: Slider(
              value: _temperature,
              min: 60,
              max: 85,
              onChanged: (v) => setState(() => _temperature = v),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('60°',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.4),
                      fontSize: 11)),
              Text('85°',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.4),
                      fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToggleCard({
    required String icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
    required Color activeColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            isActive
                ? ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return RadialGradient(
                        center: Alignment.center,
                        radius: 0.5,
                        colors: [
                          activeColor.withValues(alpha: 0.6),
                          Colors.transparent,
                        ],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.screen,
                    child: SvgPicture.asset(
                      icon,
                      width: 32,
                      height: 32,
                      colorFilter:
                          ColorFilter.mode(activeColor, BlendMode.srcIn),
                    ),
                  )
                : SvgPicture.asset(
                    icon,
                    width: 32,
                    height: 32,
                    colorFilter: ColorFilter.mode(
                      Colors.white.withValues(alpha: 0.5),
                      BlendMode.srcIn,
                    ),
                  ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isActive ? activeColor : Colors.white54,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTempButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: GlassIconButton(
        icon: Icon(icon, size: 20),
        size: 48,
        shape: GlassIconButtonShape.circle,
        onPressed: onTap,
      ),
    );
  }
}
