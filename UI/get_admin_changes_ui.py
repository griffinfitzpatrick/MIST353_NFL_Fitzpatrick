import streamlit as st
from fetch_data import post_data

def admin_changes_ui():
    st.header("My Admin Change History")

    # Ensure admin is logged in
    if "user_id" not in st.session_state:
        st.error("You must be logged in as an Admin to view your changes.")
        return

    nfl_admin_id = st.session_state["user_id"]

    if st.button("Load My Changes"):
        params = {"nfl_admin_id": nfl_admin_id}
        changes_df = post_data("get_admin_changes/", params)

        # Error handling
        if isinstance(changes_df, dict) and "error" in changes_df:
            st.error(changes_df["error"])
            return

        if changes_df is None or len(changes_df) == 0:
            st.info("No changes recorded yet.")
            return

        st.subheader("Changes You Have Made")
        st.dataframe(changes_df)