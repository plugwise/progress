### Const diff

```
egrep -v "^#|^$|\"\"\"" homeassistant/components/plugwise/const.py | cut -f 1 -d '=' | tr -d " " | while read const
do echo "#### $const"; grep -l $const homeassistant/components/plugwise/*py tests/components/plugwise/*py
done
```

#### DOMAIN

```
homeassistant/components/plugwise/__init__.py
homeassistant/components/plugwise/binary_sensor.py
homeassistant/components/plugwise/climate.py
homeassistant/components/plugwise/config_flow.py
homeassistant/components/plugwise/const.py
homeassistant/components/plugwise/sensor.py
homeassistant/components/plugwise/switch.py
tests/components/plugwise/common.py
tests/components/plugwise/test_config_flow.py
```

#### SENSOR_MAP_MODEL

```
homeassistant/components/plugwise/const.py
homeassistant/components/plugwise/sensor.py
```

#### SENSOR_MAP_UOM

```
homeassistant/components/plugwise/const.py
homeassistant/components/plugwise/sensor.py
```

#### SENSOR_MAP_DEVICE_CLASS

```
homeassistant/components/plugwise/const.py
homeassistant/components/plugwise/sensor.py
```

#### SENSOR_MAP_ICON

```
homeassistant/components/plugwise/const.py
```

#### DEFAULT_NAME

```
homeassistant/components/plugwise/const.py
```

#### DEFAULT_USERNAME

```
homeassistant/components/plugwise/const.py
```

#### DEFAULT_TIMEOUT

```
homeassistant/components/plugwise/const.py
```

#### DEFAULT_PORT

```
homeassistant/components/plugwise/const.py
```

#### DEFAULT_MIN_TEMP

```
homeassistant/components/plugwise/climate.py
homeassistant/components/plugwise/const.py
```

#### DEFAULT_MAX_TEMP

```
homeassistant/components/plugwise/climate.py
homeassistant/components/plugwise/const.py
```

#### DEFAULT_SCAN_INTERVAL

```
homeassistant/components/plugwise/__init__.py
homeassistant/components/plugwise/config_flow.py
homeassistant/components/plugwise/const.py
tests/components/plugwise/test_config_flow.py
```

#### CONF_MIN_TEMP

```
homeassistant/components/plugwise/const.py
```

#### CONF_MAX_TEMP

```
homeassistant/components/plugwise/const.py
```

#### CONF_THERMOSTAT

```
homeassistant/components/plugwise/const.py
```

#### CONF_POWER

```
homeassistant/components/plugwise/const.py
```

#### CONF_HEATER

```
homeassistant/components/plugwise/const.py
```

#### CONF_SOLAR

```
homeassistant/components/plugwise/const.py
```

#### CONF_GAS

```
homeassistant/components/plugwise/const.py
```

#### ATTR_ILLUMINANCE

```
homeassistant/components/plugwise/const.py
homeassistant/components/plugwise/sensor.py
```

#### UNIT_LUMEN

```
homeassistant/components/plugwise/const.py
homeassistant/components/plugwise/sensor.py
```

#### CURRENT_HVAC_DHW

```
homeassistant/components/plugwise/const.py
```

#### DEVICE_STATE

```
homeassistant/components/plugwise/const.py
homeassistant/components/plugwise/sensor.py
```

#### SCHEDULE_ON

```
homeassistant/components/plugwise/climate.py
homeassistant/components/plugwise/const.py
```

#### SCHEDULE_OFF

```
homeassistant/components/plugwise/climate.py
homeassistant/components/plugwise/const.py
```

#### COOL_ICON

```
homeassistant/components/plugwise/const.py
homeassistant/components/plugwise/sensor.py
```

#### FLAME_ICON

```
homeassistant/components/plugwise/binary_sensor.py
homeassistant/components/plugwise/const.py
homeassistant/components/plugwise/sensor.py
```

#### FLOW_OFF_ICON

```
homeassistant/components/plugwise/binary_sensor.py
homeassistant/components/plugwise/const.py
```

#### FLOW_ON_ICON

```
homeassistant/components/plugwise/binary_sensor.py
homeassistant/components/plugwise/const.py
```

#### GAS_ICON

```
homeassistant/components/plugwise/const.py
```

#### IDLE_ICON

```
homeassistant/components/plugwise/binary_sensor.py
homeassistant/components/plugwise/const.py
homeassistant/components/plugwise/sensor.py
```

#### POWER_ICON

```
homeassistant/components/plugwise/const.py
```

#### POWER_FAILURE_ICON

```
homeassistant/components/plugwise/const.py
```

#### SWELL_SAG_ICON

```
homeassistant/components/plugwise/const.py
```

#### SWITCH_ICON

```
homeassistant/components/plugwise/const.py
```

#### UNDO_UPDATE_LISTENER

```
homeassistant/components/plugwise/__init__.py
homeassistant/components/plugwise/const.py
```

#### COORDINATOR

```
homeassistant/components/plugwise/__init__.py
homeassistant/components/plugwise/binary_sensor.py
homeassistant/components/plugwise/climate.py
homeassistant/components/plugwise/const.py
homeassistant/components/plugwise/sensor.py
homeassistant/components/plugwise/switch.py
