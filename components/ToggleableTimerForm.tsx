import React, { useState } from "react";
import { StyleSheet, View } from "react-native";
import NewTimerForm from "./NewTimerForm";
import { TimerButton } from "./TimerButton";

const ToggleableTimerForm: React.FC<{}> = () => {
  const [isOpen, setIsOpen] = useState(false);
  return (
    <View style={[styles.container, !isOpen && styles.buttonPadding]}>
      {isOpen ? (
        <NewTimerForm
          onCancel={() => setIsOpen(!isOpen)}
          onCreatePress={() => setIsOpen(!isOpen)}
        />
      ) : (
        <TimerButton
          title="+"
          small={false}
          onPress={() => setIsOpen(!isOpen)}
          color="black"
        />
      )}
    </View>
  );
};
const styles = StyleSheet.create({
  container: {
    paddingVertical: 10,
  },
  buttonPadding: {
    paddingHorizontal: 15,
  },
});

export default ToggleableTimerForm;
