mosquitto_pub -h 192.168.1.3 -t cmnd/sonoff_ir_test/IRSEND -m "{ "protocol": row, "bits": 1000, "data": 3312111111211111111112222112221111112211112111111111122133121111112111111111122221122211111122111121111111111221331211111121111111111222211222111111221111211111111112214 }"

mosquitto_pub -h 192.168.1.3 -t cmnd/sonoff_ir_test/IRSEND -m '{ "protocol": "RF", "bits": 360, "data": 111011001100000100010001 }'
sleep 2
mosquitto_pub -h 192.168.1.3 -t cmnd/sonoff_ir_test/IRSEND -m '{ "protocol": "RF", "bits": 360, "data": 111011001100000000010000 }'
sleep 2
mosquitto_pub -h 192.168.1.3 -t cmnd/sonoff_ir_test/IRSEND -m '{ "protocol": "SAMSUNG", "bits": 32, "data": E0E019E6 }'
sleep 2

