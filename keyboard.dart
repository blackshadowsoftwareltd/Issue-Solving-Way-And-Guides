///? hide keyboard
FocusScope.of(context).unfocus();

///? The keyboard will be hidden when the user is taped outside in the Textfield.
Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child:
      )
